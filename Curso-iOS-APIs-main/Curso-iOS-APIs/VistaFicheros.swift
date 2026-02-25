//
//  VistaFicheros.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 7 on 25/2/26.
//

import SwiftUI

struct Usuario: Codable, Identifiable {
    var id = UUID()
    var nombre: String
    var edad: Int
    
    enum CodingKeys: String, CodingKey {
        case id, nombre, edad
    }
    
    //Init personalizado para decodificar
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //tratamos de decodificar el id. Si no existe, le asignamos uno
        self.id = try container.decodeIfPresent(UUID.self, forKey:.id) ?? UUID()
        
        self.nombre = try container.decode(String.self, forKey: .nombre)
        self.edad = try container.decode(Int.self, forKey: .edad)
    }
    
}

struct VistaFicheros: View {
    
    @State private var usuarios: [Usuario] = []
    
    
    var body: some View {
        VStack(spacing: 15) {
            List {
                ForEach($usuarios) { $usuario in
                    
                    HStack {
                        TextField("Nombre", text: $usuario.nombre)
                        TextField("Edad", value: $usuario.edad, format:  .number)
                            .frame(width: 80)
                    }
                }
            }
            
            Button("Cargar JSON del Bundle"){ cargarJSONDelBundle()}
            Button("Guardar JSON en Documents") {guardarJSON()}
            Button("Cargar JSON Guardado en Documents") { cargarJSONGuardado()}
        }
    }
    
    func cargarJSONDelBundle() {
        
        //Lista los archivos de tipo json (para debug)
        //print(Bundle.main.paths(forResourcesOfType: "json", inDirectory: nil))
        guard let url = Bundle.main.url(forResource: "usuarios", withExtension: ".json") else {
            print("No se encontró el archivo")
            return
    }
    do {
        let data = try Data(contentsOf: url)
        usuarios = try JSONDecoder().decode([Usuario].self, from: data)
    } catch {
        print("Error cargando el JSON",error)
    }
}
    
    func guardarJSON() {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted //Para que el JSON sea legible
        
        do {
            let data = try encoder.encode(usuarios)
            let url = getDocumentDirectory().appendingPathComponent("usuarios_guardados.json")
            
            try data.write(to: url)
            print("Guardado en \(url.path)")
        } catch {
            print("Error guardando", error)
        }
    }
    
    func cargarJSONGuardado() {
        let url = getDocumentDirectory().appendingPathComponent("usuarios_guardados.json")
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("No existe el archivo guardado")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            usuarios = try JSONDecoder().decode([Usuario].self, from: data)
        }
        catch {
            print("Error al cargar:", error)
        }
        
    }
    
    func getDocumentDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    

}

#Preview {
    VistaFicheros()
}

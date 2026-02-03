//
//  ViewModels.swift
//  Curso-iOS-PropertyWrappers
//
//  Created by Equipo 7 on 2/2/26.
//

import SwiftUI

struct Articulo: Identifiable {
    let id = UUID()
    var titulo: String
    var completado = false
    
}

@Observable
class PerfilUsuario {
    var nombre = "María"
    var edad = 45
}

@Observable
class AppData {
    
    var articulos: [Articulo] = []
    var cargando = false
    var usuario = PerfilUsuario()
    
    var instanceId: ObjectIdentifier {
        ObjectIdentifier(self)
    }
    
    init() {
        print("Se ha crado una instancia de AppData: \(instanceId)")
    }
    
    deinit {
        print("Se ha destruido una instancia de AppData: \(instanceId)")
    }
    
    func cargarDatos() async {
        print("Cargando datos...")
        cargando = true
        
        //simulamos una espera para cargar los datos desde internet
        // Esto si tiene error cierra la app y ya
        // try! await Task.sleep(nanoseconds: 2_000_000_000)
       // es lo mismo que la opción de abajo
      //  try? await Task.sleep(nanoseconds: 2_000_000_000)
        
    
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
        } catch is CancellationError {
            print("Se ha cancelado la carga de datos")
        }catch {
            print("Otro error: \(error.localizedDescription)")
        }
        
        await MainActor.run {
            articulos = [
                Articulo(titulo: "Aprender SwiftUI"),
                Articulo(titulo: "Compar el nuevo iPhone"),
                Articulo(titulo: "Viajar a Japón",completado: true)
            ]
            cargando = false
        }
        print("datos cargados")
        
    }
    
    func anadirArticulo(titulo: String) {
        articulos.append(Articulo(titulo: titulo))
    }
}

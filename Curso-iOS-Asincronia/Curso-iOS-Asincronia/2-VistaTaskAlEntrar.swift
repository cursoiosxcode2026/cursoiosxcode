//
//  VistaTaskAlEntrar.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 7 on 10/2/26.
//

import SwiftUI

struct VistaTaskAlEntrar: View {
    
    @State private var nombre = "Cargando..."
    @State private var biografia = ""
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            
            Text(nombre)
                .font(.title)
                .bold()
            
            Text(biografia)
                .foregroundStyle(.secondary)
        }
    
        /*Se ejecuta el taks cuando la vista va a aparecer
        task nos cancela la ejecución automáticamente si salimos de la vista
        --------
        IMPORTANTE: NO usamos el onAppear para llamar a metodos asincronos, ya que no cancela
         la llamada asincrona en caso de que salgamos de la vista
         */
        
        .task {
            await cargarPerfil()
        }
    }
    
    func cargarPerfil() async {
        //simulamos la espera
        try? await Task.sleep(for: .seconds(2))
        
        nombre = "Pepito Pérez"
        biografia = "Estudiante de iOS y adicto al café"
    }
}

#Preview {
    VistaTaskAlEntrar()
}

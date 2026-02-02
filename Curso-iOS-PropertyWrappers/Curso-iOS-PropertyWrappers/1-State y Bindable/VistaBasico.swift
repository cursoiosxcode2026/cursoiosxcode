//
//  ContentView.swift
//  Curso-iOS-PropertyWrappers
//
//  Created by Equipo 7 on 2/2/26.
//

import SwiftUI




struct VistaBasico: View {
    // Usamos @State para inicializar y poseer el objeto. Esto nos servirá para:
    // - Para que no se creen nuevas instancias de la clase entre actualizaciones
    //de vistas
    // - Para acceder a los Bindings ($)
    @State private var viewModel = ContadorViewModel()
    
    var body: some View {
        
        Text("Hola, soy \(viewModel.name)")
        Text("Conteo a: \(viewModel.count)")
            .font(.largeTitle)
        
        TextField("Cambiar nombre", text: $viewModel.name)
        
        Button("Incrementar") {
            viewModel.incrementar()
        }
        
    }
}

#Preview {
    VistaBasico()
}

//
//  VistaMainActor.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 7 on 10/2/26.
//

import SwiftUI
import Observation
/* @MainActor asegura que las actualizaciones de la interfaz ocurran en el hilo principal
 se puede anotar:
 -La clase entera
 -Funciones especificas
 -Se puede usar la clave 'nonisolated' para excluir métodos especificos de la ejecucion en el
 hilo principal.
 */


@MainActor
@Observable
class UsuarioViewModel {
    var nombreUsuario = "Cargando..."
    
    func actualizarNombreUsuario() async {
        //Simulamos una descarga de internet
        try? await Task.sleep(for: .seconds(2))
        
        nombreUsuario = "Pepito Pérez"
    }
    
}



struct VistaMainActor: View {
@State private var viewModel = UsuarioViewModel()
    var body: some View {
        Text(viewModel.nombreUsuario)
            .task {
                await viewModel.actualizarNombreUsuario()
                
            }
       
    }
}

#Preview {
    VistaMainActor()
}

//
//  VistaHome.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI



struct VistaHome: View {
    @State private var path = NavigationPath()
    
    @State private var viewModel = DetallePerfilViewModel(
        perfil: Perfil(
            id: 1,
            username: "emilys",
            password: "emilyspass",
            image: "https://dummyjson.com/icon/emilys/128",
            company: nil,
          //  titulo: "Tester"
        )
        /*,
        viewModel: SeguidoresSeguidosViewModel() */
    )
    
   // @State private var mensajes = MensajeViewModel(idUsuario: viewModel.perfil.id)
    
    @State private var mensajes = MensajeViewModel(idUsuario: 1)

    

    
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                
                VistaFeed(viewModel: viewModel)
                    .tabItem {
                        Label("Feed", systemImage: "house")
                    }
                
                VistaBuscador()
                    .tabItem {
                        Label("Buscador", systemImage: "magnifyingglass")
                    }
                
                
                //TO DO
                VistaMensaje(viewModel: mensajes)
                    .tabItem {
                        Label("Mensajes", systemImage: "message")
                    }
                
                VistaDetallePerfil( perfil: viewModel.perfil,
                                    path: $path/*,
                                    rsViewModel: viewModel.viewModel*/)
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
            }
        }
    }
}

#Preview {
    VistaHome()
}


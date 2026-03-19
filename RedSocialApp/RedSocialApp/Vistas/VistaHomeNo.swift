//
//  VistaHome.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI



struct VistaHomeNo: View {
 //   @State private var path = NavigationPath()
    
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
    
    @State private var mensajes = MensajeViewModel(idRemitente: 1)

    

    
    
    var body: some View {
      //  NavigationStack(path: $path) {
            TabView {
                NavigationStack {
                    VistaFeed(viewModel: viewModel)
                }
                    .tabItem {
                        Label("Feed", systemImage: "house")
                    }
                NavigationStack {
                    VistaBuscador()
                }
                    .tabItem {
                        Label("Buscador", systemImage: "magnifyingglass")
                    }
                
                
                
                NavigationStack {
                    VistaMensaje(viewModel: mensajes)
                }
                    .tabItem {
                        Label("Mensajes", systemImage: "message")
                    }
                
               /* NavigationStack {
                    VistaDetallePerfil(perfil: usuario,usuarioVM: $usuarioVM  perfil: viewModel.perfil /*,
                                                                 path: $path,*/
                    )
                }
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
                */
                
                //TO DO
              /*  NavigationStack {
                    VistaUsuario()
                }
                    .tabItem {
                        Label("Usuarios", systemImage: "person.3")
                    }*/
            }
        }
    }

#Preview {
    VistaHomeNo()
}


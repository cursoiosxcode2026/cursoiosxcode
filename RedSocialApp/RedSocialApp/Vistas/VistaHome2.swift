//
//  VistaHome.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaHome2: View {
    @State var usuarioVM = UsuarioViewModel()
    
    var body: some View {
        NavigationStack {
            if let usuario = usuarioVM.usuarioActual {
                // App cargada con usuario activo
                TabView {
                    // Feed
                    VistaFeed(viewModel: DetallePerfilViewModel(perfil: usuario))
                        .tabItem { Label("Feed", systemImage: "house") }
                    
                    // Buscador
                    VistaBuscador()
                        .tabItem { Label("Buscador", systemImage: "magnifyingglass") }
                    
                    // Mensajes
                    VistaMensaje(viewModel: MensajeViewModel(idRemitente: usuario.id))
                        .tabItem { Label("Mensajes", systemImage: "message") }
                    
                    // Perfil
                    VistaDetallePerfil(perfil: usuario)
                        .tabItem { Label("Perfil", systemImage: "person") }
                    
                    // Usuarios / selector
                    VistaUsuario()
                        .tabItem { Label("Usuarios", systemImage: "person.3") }
                }
            } else {
                // Usuario no seleccionado → mostrar VistaUsuario
                VistaUsuario()
            }
        }
        .task {
            await usuarioVM.cargarPerfiles()
        }
        .environmentObject(usuarioVM) // Para que VistaUsuario pueda cambiar usuarioActual
    }
}

#Preview {
    VistaHome2()
}


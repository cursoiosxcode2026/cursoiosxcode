//
//  VistaHome.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaHome: View {
    @State var usuarioVM = UsuarioViewModel()
    @State private var mensajeVMs: [Int: MensajeViewModel] = [:]
    
    
    var body: some View {
        Group {
            if let usuario = usuarioVM.usuarioActual {
                TabView {
                    // Feed
                    NavigationStack {
                        VistaFeed(
                            viewModel: DetallePerfilViewModel(perfil: usuario),
                            usuarioViewModel: usuarioVM,
                            origen: .tabPrincipal
                        )
                    }
                    .tabItem { Label("Feed", systemImage: "house") }
                    
                    // Buscador
                    NavigationStack {
                        VistaBuscador()
                    }
                    .tabItem { Label("Buscador", systemImage: "magnifyingglass") }
                    
                    // Mensajes
                    NavigationStack {
                        if let vm = mensajeVMs[usuario.id] {
                            VistaMensaje(viewModel: vm)
                        } else {
                            ProgressView("Cargando mensajes…")
                        }
                    }
                    .tabItem { Label("Mensajes", systemImage: "message") }
                    
                    // Perfil
                    NavigationStack {
                        VistaDetallePerfil(perfil: usuario, usuarioVM: $usuarioVM)
                    }
                    .tabItem { Label("Perfil", systemImage: "person") }
                }
                .task {
                    // Crear mensajeViewModel solo una vez por usuario
                    if mensajeVMs[usuario.id] == nil {
                        mensajeVMs[usuario.id] = MensajeViewModel(idRemitente: usuario.id)
                    }
                }
            } else {
                VistaUsuario(usuarioVM: usuarioVM)
            }
        }
        .task {
            await usuarioVM.cargarPerfiles()
        }
    }
}

#Preview {
    VistaHome()
}

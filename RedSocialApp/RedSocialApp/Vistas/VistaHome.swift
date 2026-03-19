//
//  VistaHome.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

/*
import SwiftUI

struct VistaHome2: View {
    @State var usuarioVM = UsuarioViewModel()
    @State var mensajeVM: MensajeViewModel? = nil
    
    var body: some View {
        Group { // envuelve para garantizar que siempre se devuelve View
            if let usuario = usuarioVM.usuarioActual {
                TabView {
                    NavigationStack {
                        VistaFeed(viewModel: DetallePerfilViewModel(perfil: usuario))
                    }
                    .tabItem { Label("Feed", systemImage: "house") }
                    
                    NavigationStack {
                        VistaBuscador()
                    }
                    .tabItem { Label("Buscador", systemImage: "magnifyingglass") }
                    
                    NavigationStack {
                      //  VistaMensaje(viewModel: MensajeViewModel(idRemitente: usuario.id))
                        
                        // Inicializar solo si es nil
                                               if mensajeVM == nil {
                                                   let vm = MensajeViewModel(idRemitente: usuario.id)
                                                   DispatchQueue.main.async { mensajeVM = vm }
                                               }
                                               if let vm = mensajeVM {
                                                   VistaMensaje(viewModel: vm)
                                               } else {
                                                   ProgressView() // mientras se inicializa
                                               }
                    }
                    .tabItem { Label("Mensajes", systemImage: "message") }
                    
                    NavigationStack {
                        VistaDetallePerfil(perfil: usuario)
                    }
                    .tabItem { Label("Perfil", systemImage: "person") }
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
    VistaHome2()
}

*/

/*

import SwiftUI

struct VistaHome: View {
    @State var usuarioVM = UsuarioViewModel()
    @State var mensajeVM: MensajeViewModel? = nil
    
    var body: some View {
        Group {
            if let usuario = usuarioVM.usuarioActual {
                TabView {
                    // Feed
                    NavigationStack {
                        VistaFeed(viewModel: DetallePerfilViewModel(perfil: usuario))
                    }
                    .tabItem { Label("Feed", systemImage: "house") }
                    
                    // Buscador
                    NavigationStack {
                        VistaBuscador()
                    }
                    .tabItem { Label("Buscador", systemImage: "magnifyingglass") }
                    
                    // Mensajes
                    NavigationStack {
                        // Crear un MensajeViewModel único por usuario
                        VistaMensaje(viewModel: MensajeViewModel(idRemitente: usuario.id))
                    }
                    .tabItem { Label("Mensajes", systemImage: "message") }
                    
                    // Perfil
                    NavigationStack {
                        VistaDetallePerfil(perfil: usuario, usuarioVM: $usuarioVM)
                    }
                    .tabItem { Label("Perfil", systemImage: "person") }
                }
            } else {
                // Ningún usuario seleccionado → mostrar selector
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
*/


/*
import SwiftUI

struct VistaHome: View {
    @State var usuarioVM = UsuarioViewModel()
    
    // Diccionario para mantener un MensajeViewModel por usuario
    @State private var mensajeVMs: [Int: MensajeViewModel] = [:]
    
    var body: some View {
        Group {
            if let usuario = usuarioVM.usuarioActual {
                TabView {
                    // Feed
                    NavigationStack {
                        VistaFeed(viewModel: DetallePerfilViewModel(perfil: usuario))
                    }
                    .tabItem { Label("Feed", systemImage: "house") }
                    
                    // Buscador
                    NavigationStack {
                        VistaBuscador()
                    }
                    .tabItem { Label("Buscador", systemImage: "magnifyingglass") }
                    
                    // Mensajes
                    NavigationStack {
                        // Usamos un Group para que SwiftUI reciba siempre una View
                        Group {
                            // Obtener o crear MensajeViewModel para el usuario actual
                            let vm = mensajeVMs[usuario.id] ?? {
                                let nuevoVM = MensajeViewModel(idRemitente: usuario.id)
                                mensajeVMs[usuario.id] = nuevoVM
                                return nuevoVM
                            }()
                            
                            VistaMensaje(viewModel: vm)
                        }
                    }
                    .tabItem { Label("Mensajes", systemImage: "message") }
                    
                    // Perfil
                    NavigationStack {
                        VistaDetallePerfil(perfil: usuario, usuarioVM: $usuarioVM)
                    }
                    .tabItem { Label("Perfil", systemImage: "person") }
                }
            } else {
                // Ningún usuario seleccionado → mostrar selector
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
} */


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
                        VistaFeed(viewModel: DetallePerfilViewModel(perfil: usuario))
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
                    // Crear MensajeViewModel solo una vez por usuario
                    if mensajeVMs[usuario.id] == nil {
                        mensajeVMs[usuario.id] = MensajeViewModel(idRemitente: usuario.id)
                    }
                }
            } else {
                // Ningún usuario seleccionado → mostrar selector
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

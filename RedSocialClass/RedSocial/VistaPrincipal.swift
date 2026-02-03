//
//  VistaPrincipal.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct VistaPrincipal: View {
    @Environment(RedSocial.self) var redSocial
    
    var body: some View {
        
        
        TabView(selection: Bindable(redSocial).tabSeleccionado) {
      /*     NavigationStack {
                            VistaPrincipal()
                        }
                        .tabItem { Label("Home", systemImage: "house") }
                        .tag(0)
           NavigationStack {
                            VistaBuscador()
                        }
                        .tabItem { Label("Buscar", systemImage: "magnifyingglass") }
                        .tag(1)

           NavigationStack {
                            VistaMensaje()
                        }
                        .tabItem { Label("Mensajes", systemImage: "paperplane") }
                        .tag(2)
            
            NavigationStack {
                           VistaPerfil()
                       }
                       .tabItem { Label("Perfil", systemImage: "person") }
                       .tag(3)
        }
        .task {
            await redSocial.cargarDatos()
        }
        .overlay {
            if redSocial.cargando {
                ProgressView("Cargando...")
            }
        }
    }
}

#Preview {
    VistaPrincipal()
}

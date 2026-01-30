//
//  ContentView.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct RedSocial: View {
    @State private var nombreUsuario : String = ""
    @State private var tabSeleccionado = 0
    @State private var perfil = Perfil(nombre: "Paloma", titulo: "UGC Spain", descripcion: "Creadora de contenido, ideas y momentos del día a día.", reels: "25", seguidores: "15k",seguidos: "4k")
    
    var body: some View {
    
        TabView  (selection: $tabSeleccionado){
        /*    NavigationStack {
                VistaPrincipal(tabSeleccionado: $tabSeleccionado)
            }
            .tabItem {
                Label("Explorar",systemImage: "map")
            }.tag(0)
            
            NavigationStack {
                VistaMensajes(tabSeleccionado: $tabSeleccionado)
            }
            .tabItem {
                Label("Mi perfil",systemImage: "person.circle")
            }.tag(1)
            
            NavigationStack {
                VistaBuscador(tabSeleccionado: $tabSeleccionado)
            }
            .tabItem {
                Label("Mi perfil",systemImage: "person.circle")
            }.tag(2)
          */
            NavigationStack {
                VistaPerfil(perfil: $perfil)
            }
            .tabItem {
                Label("Mi perfil",systemImage: "person.circle")
            }.tag(0)
        }
        
    }
}


#Preview {
    RedSocial()
}

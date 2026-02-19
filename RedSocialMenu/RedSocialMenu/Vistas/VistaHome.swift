//
//  VistaHome.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 19/2/26.
//

import SwiftUI

struct VistaHome: View {
    
    var body: some View {
        TabView {
            
          Text("VistaFeed()")
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            
           Text("VistaBuscador()")
                .tabItem {
                    Label("Buscador", systemImage: "magnifyingglass")
                }
            
            Text("VistaDetallePerfil()")
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
    }
}

#Preview {
    VistaHome()
}

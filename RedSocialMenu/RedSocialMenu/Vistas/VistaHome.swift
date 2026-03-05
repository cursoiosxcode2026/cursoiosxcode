//
//  VistaHome.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 19/2/26.
//

import SwiftUI

struct VistaHome: View {
    
    @State private var viewModel = DetallePerfilViewModel(
        perfil: Perfil(
            id: 1,
            username: "Paloma",
            password: "1234",
            image: "",
            company: nil,
            titulo: "Tester"
        ),
        viewModel: SeguidoresSeguidosViewModel()
    )
    
    var body: some View {
        TabView {
            
          VistaFeed(viewModel: viewModel)
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

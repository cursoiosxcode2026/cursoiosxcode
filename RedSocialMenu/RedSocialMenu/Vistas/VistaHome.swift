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
            image: "https://dummyjson.com/icon/emilys/128",
            company: nil,
          //  titulo: "Tester"
        ),
        viewModel: SeguidoresSeguidosViewModel()
    )
    
    @State private var path = NavigationPath()
    
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
                
                VistaDetallePerfil( perfil: viewModel.perfil,
                                    path: $path,
                                    rsViewModel: viewModel.viewModel)
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

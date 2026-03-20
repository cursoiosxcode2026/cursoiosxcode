//
//  VistaFeed.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaFeed: View {
    @State private var viewModel: DetallePerfilViewModel
    
    init(viewModel: DetallePerfilViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Feed de \(viewModel.perfil.username)")
                    .font(.title2).bold()
                
            }
            ScrollView {
                
                VStack {
                        ForEach($viewModel.post) { $post in
                            HStack(){
                                NavigationLink {
                                    VistaDetallePost(post: $post)
                                } label: {
                                    AsyncImage(url: URL(string: post.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 50, height: 50)
                                    .clipShape(Rectangle())
                                }
                                Text(post.name)
                                Spacer()
                                Text(post.air_date).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                }
                .padding()
            }
            .task {
                await viewModel.cargarDatosCompletos()
            }
        }
        
       /*.navigationTitle("Feed de \(viewModel.perfil.username)")
       .navigationBarTitleDisplayMode(.inline)
        
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
        */
    }
}
    #Preview {
        
        let perfil = Perfil(
            id: 1,
            username: "emilys",
            password: "emilyspass",
            image: "https://dummyjson.com/icon/emilys/128",
            company: nil,
            //titulo: "Tester"
        )
        
       // let seguidoresVM = SeguidoresSeguidosViewModel()
        
        VistaFeed(
            viewModel: DetallePerfilViewModel(
                perfil: perfil/*,
                viewModel: seguidoresVM*/
            )
        )
    }


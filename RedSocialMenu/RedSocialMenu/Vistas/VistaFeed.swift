//
//  VistaFeed.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 19/2/26.
//

import SwiftUI

struct VistaFeed: View {
    @State private var viewModel: DetallePerfilViewModel
   /* let perfil = Perfil(
        id: 1,
        username: "Paloma",
        password: "1234",
        image: "https://via.placeholder.com/150",
        company: nil,
        titulo: "Tester"
    )
    */
    init(viewModel: DetallePerfilViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
            
            VStack {
                
                Text("Feed de \(viewModel.perfil.username)")
                
                ForEach(viewModel.post) { post in
                    HStack(){
                        NavigationLink {
                            VistaDetallePost(post: post)
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
            .task {
                await viewModel.cargarDatosCompletos()
            }
        }
    }

    #Preview {
        
        let perfil = Perfil(
            id: 1,
            username: "Paloma",
            password: "1234",
            image: "",
            company: nil,
            titulo: "Tester"
        )
        
        let seguidoresVM = SeguidoresSeguidosViewModel()
        
        VistaFeed(
            viewModel: DetallePerfilViewModel(
                perfil: perfil,
                viewModel: seguidoresVM
            )
        )
    }

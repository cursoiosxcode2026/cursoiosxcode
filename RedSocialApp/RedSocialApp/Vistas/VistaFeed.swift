//
//  VistaFeed.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

enum OrigenFeed {
    case tabPrincipal
    case perfil
}
struct VistaFeed: View {
    @State private var viewModel: DetallePerfilViewModel
    @State private var usuarioViewModel: UsuarioViewModel
    let origen: OrigenFeed
    var titulo: String {
        let esMiUsuario = viewModel.perfil.id == usuarioViewModel.usuarioActual?.id
        
        switch origen {
        case .tabPrincipal:
            return "Mi feed"
            
        case .perfil:
            return esMiUsuario
                ? "Mis posts"
                : "Posts de \(viewModel.perfil.username)"
        }
    }
   
    /*Al usar la misma VistaFeed cuando es feed y cuando son mis post o los de otra persona,
     hay que tener en cuenta desde donde se llama para devolver DetallePerfilViewModel.posts
     (mis post o del usuario x que se guardan en cache) o DetallePerfilViewModel.postsFeed(que van cambiando cada vez que haces click en la tab
     */
    
    var postBindings: [Binding<Post>] {
        switch origen {
        case .tabPrincipal:
            return viewModel.postsFeed.indices.map { index in
                $viewModel.postsFeed[index]
            }
        case .perfil:
            return viewModel.posts.indices.map { index in
                $viewModel.posts[index]
            }
        }
    }
    
    
    
    init(
        viewModel: DetallePerfilViewModel,
        usuarioViewModel: UsuarioViewModel,
        origen: OrigenFeed
    ) {
        _viewModel = State(initialValue: viewModel)
        _usuarioViewModel = State(initialValue: usuarioViewModel)
        self.origen = origen
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text(titulo)
                    .font(.title2).bold()
                
            }
            ScrollView {
                
                VStack {
                    //Aqui se usa el DetallePerfilViewModel.postsFeed o DetallePerfilViewModel.posts
                    //dependiendo de la variable postBindings
                    ForEach(postBindings) { $post in
                        NavigationLink {
                            VistaDetallePost(post: $post)
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: post.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Rectangle())
                                Spacer()
                                Text(post.name)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                Text(post.air_date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                }
                .padding()
            }
            .task {
                await viewModel.cargarDatosCompletos()
            }
        }
    }
}
#Preview {
    let perfil = Perfil(
        id: 1,
        username: "emilys",
        password: "emilyspass",
        image: "https://dummyjson.com/icon/emilys/128",
        company: nil
    )
    
    let usuarioVM = UsuarioViewModel()
    usuarioVM.usuarioActual = perfil
    
    return VistaFeed(
        viewModel: DetallePerfilViewModel(perfil: perfil),
        usuarioViewModel: usuarioVM,
        origen: .tabPrincipal
    )
}


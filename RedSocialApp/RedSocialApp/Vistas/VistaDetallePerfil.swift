//
//  VistaDetallePerfil.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI
import Observation

struct VistaDetallePerfil: View {
    
   // @Binding var path: NavigationPath
    @State private var viewModel: DetallePerfilViewModel
   // private var rsViewModel: SeguidoresSeguidosViewModel
    
    init(perfil: Perfil/*, path: Binding<NavigationPath>*/) {
       // self._path = path
      
        
        self._viewModel = State(wrappedValue: DetallePerfilViewModel(perfil: perfil))
        
    }
    
    
 
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: viewModel.perfil.image)) { img in
                    img.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 150)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text(viewModel.perfil.username)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                Text(viewModel.titulo)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if viewModel.isLoading {
                    ProgressView("Cargando detalles...")
                } else {
                    VStack(alignment: .leading) {
                        Text("Posts: \(viewModel.post.count)")
                            .font(.headline)
                        
                        
                        
                        
                        ForEach(viewModel.post.indices, id: \.self) { index in
                            let postBinding = $viewModel.post[index]
                            let post = viewModel.post[index] // solo para filtrar o mostrar datos si quieres
                            
                            HStack {
                                NavigationLink {
                                    VistaDetallePost(post: postBinding) // pasamos binding
                                } label: {
                                    AsyncImage(url: URL(string: post.image)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 40, height: 40)
                                    .clipShape(Rectangle())
                                    
                                    Text(post.name)
                                    Spacer()
                                    Text(post.air_date).font(.caption).foregroundStyle(.secondary)
                                }
                            }
                        }
                        if !viewModel.perfilesRelacionados.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Perfiles relacionados")
                                    .font(.title2.bold())
                                    .padding(.vertical)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(viewModel.perfilesRelacionados) { perfil in
                                            //  NavigationLink(value: perfil) {
                                            NavigationLink(destination: VistaDetallePerfil(perfil: perfil/*, path: $path*/)) {
                                                VStack {
                                                    AsyncImage(url: URL(string: perfil.image)) { img in
                                                        img.resizable().scaledToFill()
                                                    } placeholder: {
                                                        Color.gray.opacity(0.3)
                                                    }
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(Circle())
                                                    Text(perfil.username)
                                                        .font(.caption)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                               VistaFeed(viewModel: viewModel)
                } label: {
                    Image(systemName: "photo.fill")
                }
            }
        }
        .task {
            await viewModel.cargarDatosCompletos()
        }
    }
}

struct VistaDetallePerfilPreview: View {
    
  //  @State var path = NavigationPath()
    
    var body: some View {
        
        let perfil = Perfil(
            id: 1,
            username: "emilys",
            password: "emilyspass",
            image: "https://dummyjson.com/icon/emilys/128",
            company: nil
        )
        
        VistaDetallePerfil(perfil: perfil/*, path: $path*/)
    }
}

#Preview {

    VistaDetallePerfilPreview()
}


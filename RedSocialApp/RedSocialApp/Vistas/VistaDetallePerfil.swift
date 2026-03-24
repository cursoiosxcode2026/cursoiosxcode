//
//  VistaDetallePerfil.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI
import Observation

struct VistaDetallePerfil: View {
    
    @State private var viewModel: DetallePerfilViewModel
    @Binding var usuarioVM: UsuarioViewModel // binding para poder cerrar sesión
    
    init(perfil: Perfil, usuarioVM: Binding<UsuarioViewModel>) {
        self._viewModel = State(wrappedValue: DetallePerfilViewModel(perfil: perfil))
        self._usuarioVM = usuarioVM
    }
    
    var body: some View {
      //  ScrollView {
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
                ScrollView {
                if viewModel.isLoading {
                    ProgressView("Cargando detalles...")
                } else {
                    VStack(alignment: .leading) {
                        Text("Número de posts: \(viewModel.post.count)")
                            .font(.headline)
                        
                        ForEach(viewModel.post.indices, id: \.self) { index in
                            let postBinding = $viewModel.post[index]
                            let post = viewModel.post[index]
                            
                            HStack {
                                NavigationLink {
                                    VistaDetallePost(post: postBinding)
                                } label: {
                                    AsyncImage(url: URL(string: post.image)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 40, height: 40)
                                    .clipShape(Rectangle())
                                    Spacer()
                                    Text(post.name)
                                    Spacer()
                                    Text(post.air_date)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
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
                                            NavigationLink(destination: VistaDetallePerfil(perfil: perfil, usuarioVM: $usuarioVM)) {
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
                        
                        // ⚠️ Botón de Cerrar sesión
                        if viewModel.perfil.id == usuarioVM.usuarioActual?.id {
                            Button(role: .destructive) {
                                usuarioVM.usuarioActual = nil
                            } label: {
                                Text("Cerrar sesión")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red.opacity(0.1))
                                    .foregroundColor(.red)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 30)
                        }
                        
                        
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    VistaFeed(
                        viewModel: viewModel,
                        usuarioViewModel: usuarioVM,
                        origen: .perfil
                    )
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

    #Preview {
        let perfil = Perfil(
            id: 1,
            username: "emilys",
            password: "emilyspass",
            image: "https://dummyjson.com/icon/emilys/128",
            company: nil
        )
        
        // Para preview, creamos un UsuarioViewModel temporal
        VistaDetallePerfil(perfil: perfil, usuarioVM: .constant(UsuarioViewModel()))
    }


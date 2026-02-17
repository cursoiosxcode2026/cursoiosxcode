//
//  VistaDetallePersonaje.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
//
import SwiftUI
import Observation

struct VistaDetallePerfil: View {
    
    @Binding var path: NavigationPath
    @State private var viewModel: DetallePerfilViewModel
    private var rsViewModel: RedSocialViewModel
    
    init(perfil: Perfil, path: Binding<NavigationPath>, rsViewModel: RedSocialViewModel) {
        self._path = path
        self.rsViewModel = rsViewModel
      //  self._viewModel = State(initialValue: DetallePerfilViewModel(perfil: perfil))
        
        self._viewModel = StateObject(wrappedValue: DetallePerfilViewModel(perfil: perfil, viewModel: rsViewModel))
        
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
                
                Text(viewModel.detalle?.titulo ?? viewModel.perfil.titulo ?? "Sin título")
                    .font(.title2.bold())
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if viewModel.isLoading {
                    ProgressView("Cargando detalles...")
                } else {
                    VStack(alignment: .leading) {
                        Text("Posts: \(viewModel.post.count)")
                            .font(.headline)
                        ForEach(viewModel.post) { post in
                            HStack {
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
                                    .frame(width: 40, height: 40)
                                    .clipShape(Rectangle())
                                }
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
                                        NavigationLink(value: perfil) {
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
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    path = NavigationPath()
                } label: {
                    Image(systemName: "house.fill")
                }
            }
        }
        .task {
            await viewModel.cargarDatosCompletos()
        }
    }
}


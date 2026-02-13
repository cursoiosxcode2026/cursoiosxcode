//
//  ContentView.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
//

/*import SwiftUI

struct VistaRedSocial: View {
    @State private var viewModel = RedSocialViewModel()
    
    @State private var path = NavigationPath()

    var body: some View {

        NavigationStack (path: $path){
            VStack {

                if viewModel.isLoading {
                    ProgressView("Carga interdimensional...")
                        .controlSize(.large)
                    //si errorMessage no es nil, ejecutará
                    //este codigo:
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )

                    Button("Reintentar") {
                        Task { await viewModel.cargarDatos() }
                    }

                } else {
                    List(viewModel.perfiles) { perfil in
                        
                        NavigationLink(value: perfil) {
                            HStack {
                                
                                //carga de la imagen
                                
                                AsyncImage(url: URL(string: perfil.image)) {
                                    imagen in
                                    imagen.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(perfil.username)
                                        .font(.headline)
                                    Text(perfil.titulo)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Red Social")
            .navigationDestination(for: Perfil.self, destination: { perfil in
                VistaDetallePerfil(perfil: perfil, path: $path)
                
                
            })
            .task {
                await viewModel.cargarDatos()
            }
        }

    }
}

#Preview {
    VistaRedSocial()
}
*/

import SwiftUI

struct VistaRedSocial: View {
    @State private var viewModel = RedSocialViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path){
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                        .controlSize(.large)
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                    Button("Reintentar") {
                        Task { await viewModel.cargarDatos() }
                    }
                } else {
                    List(viewModel.perfiles) { perfil in
                        NavigationLink(value: perfil) {
                            HStack {
                                AsyncImage(url: URL(string: perfil.image)) { img in
                                    img.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(perfil.username)
                                        .font(.headline)
                                    Text(perfil.titulo)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Red Social")
            .navigationDestination(for: Perfil.self) { perfil in
                VistaDetallePerfil(perfil: perfil, path: $path)
            }
            .task {
                await viewModel.cargarDatos()
            }
        }
    }
}


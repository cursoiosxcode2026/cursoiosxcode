//
//  VistaUsuario.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 18/3/26.
//

import SwiftUI

struct VistaUsuario: View {
    @Bindable var usuarioVM: UsuarioViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Usuarios")
                    .font(.title2).bold()
                    .background(Color.white)
                
                if usuarioVM.isLoading {
                    ProgressView("Cargando...")
                        .controlSize(.large)

                } else if let errorMessage = usuarioVM.errorMessage {
                    
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                    Button("Reintentar") {
                        Task { await usuarioVM.cargarPerfiles() }
                    }
                } else {
                    List(usuarioVM.perfiles) { perfil in
                        Button {
                            usuarioVM.usuarioActual = perfil
                        } label: {
                            HStack(spacing: 20) {
                                VStack {
                                    AsyncImage(url: URL(string: perfil.image)) { img in
                                        img.resizable()
                                            .scaledToFill()
                                        
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(perfil.username)
                                        .font(.headline)
                                    Text(perfil.company?.title ?? "Sin título")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                        }
                        .listRowBackground(Color.clear)
                        //Quita la linea que separa la lista
                        .listRowSeparator(.hidden)
                    }
                    //Quita el fondo gris y los bordes redondeados
                    .listStyle(.plain)
                }
                
            }
        }
        
    }
}

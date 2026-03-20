//
//  VistaUsuario.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 18/3/26.
//

import SwiftUI

struct VistaUsuario: View {
    @Bindable var usuarioVM: UsuarioViewModel // permite modificar usuarioActual

    var body: some View {
        NavigationStack  {
             VStack {
                 Text("Usuarios")
                 .font(.title2).bold()
                 //.padding()
                 
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
                            // Asignamos usuario seleccionado
                            usuarioVM.usuarioActual = perfil
                        } label: {
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
                                    Text(perfil.company?.title ?? "Sin título")
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
            
           /* .navigationTitle("Usuarios")
            .navigationBarTitleDisplayMode(.inline)
                   
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
*/
        }
    }
}


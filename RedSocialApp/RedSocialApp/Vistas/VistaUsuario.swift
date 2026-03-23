//
//  VistaUsuario.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 18/3/26.
//

/*
import SwiftUI

struct VistaUsuario: View {
    @Bindable var usuarioVM: UsuarioViewModel
    
    var body: some View {
        NavigationStack  {
            VStack {
                Text("Usuarios")
                    .font(.title2).bold()
                
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
                    //List(usuarioVM.perfiles) { perfil in
                    
                    ScrollView {
                        VStack(/*alignment: .center*/) {
                            ForEach(usuarioVM.perfiles) { perfil in
                                Button {
                                    // Asignamos usuario seleccionado
                                    usuarioVM.usuarioActual = perfil
                                } label: {
                                    HStack {
                                        VStack {
                                    
                                        AsyncImage(url: URL(string: perfil.image)) { img in
                                            img.resizable().scaledToFit()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        }
                                        VStack(alignment: .leading) {
                                            Text(perfil.username)
                                                .font(.headline)
                                            Text(perfil.company?.title ?? "Sin título")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
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
*/

import SwiftUI

struct VistaUsuario: View {
    @Bindable var usuarioVM: UsuarioViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("Usuarios")
                    .font(.title2).bold()
                    .padding(.top)

                if usuarioVM.isLoading {
                    ProgressView("Cargando...")
                        .controlSize(.large)
                        .padding()
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
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(usuarioVM.perfiles) { perfil in
                                Button {
                                    usuarioVM.usuarioActual = perfil
                                } label: {
                                    HStack(/*alignment: .center,*/ spacing: 20) {
                                        // Columna 1: Foto
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
                    

                                        // Columna 2: Nombre y compañía
                                        VStack(/*alignment: .leading,*/ spacing: 4) {
                                            Text(perfil.username)
                                                .font(.headline)
                                            Text(perfil.company?.title ?? "Sin título")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        
                                        //version 2
                                        
                                        /*
                                         }
                                         .frame(maxWidth: 400)   // limita ancho interno
                                         .contentShape(Rectangle())
                                     }
                                     .buttonStyle(PlainButtonStyle())
                                     // Este contenedor asegura centrar cada fila 100%
                                     .frame(maxWidth: .infinity, alignment: .center)
                                 }
                             }
                             .padding(.vertical)
                                         */

                                    //Spacer() // empuja el contenido hacia la izquierda
                                    }
                                  .frame(maxWidth: 400)       // limita ancho de la fila
                                  .frame(maxWidth: .infinity, alignment: .center)
                                  
                                  //.frame(maxWidth: .infinity) // centra horizontalmente la fila
                                   .padding(.horizontal, 100)
                                    
                                }
                              .buttonStyle(PlainButtonStyle()) // quita efecto por defecto
                            }
                        }
                        .padding(.vertical)
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

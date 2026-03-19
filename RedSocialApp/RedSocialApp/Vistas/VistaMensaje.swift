//
//  VistaMensaje.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaMensaje: View {
    
    @Bindable var viewModel:  MensajeViewModel // inicializado
    @State private var mostrarAnadir = false
    @State private var mensajeEditable: Mensaje?
    
    var body: some View {
        
        NavigationStack {
            
            List {
                // Usamos $viewModel.mensajes para bindings
                ForEach($viewModel.mensajes) { $mensaje in
                    Text("\(mensaje.idReceptor)")
                    HStack(alignment: .top, spacing: 12) {
                        // Imagen del receptor solo si existe
                       AsyncImage( url: URL(string: viewModel.perfilUsuario(id: mensaje.idReceptor)?.image ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(height: 50)
                      //  Text(perfil?.image ?? "\(mensaje.idReceptor)")
                        // Texto del mensaje y usuario
                      //  VStack(alignment: .leading, spacing: 4) {
                           /* Text(viewModel.perfilUsuario(id: mensaje.idReceptor)?.username
                                 ?? "Usuario \(mensaje.idReceptor)")
                                .font(.headline) */
                            Text(mensaje.texto)
                                .font(.body)
                            Text(mensaje.fecha, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                      //  }
                    }
                    .contentShape(Rectangle()) // toda la fila tocable
                    .onTapGesture {
                        mensajeEditable = mensaje
                    }
                }
                .onDelete(perform: viewModel.borrarMensaje)
            }
            .navigationTitle("Mis mensajes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Sheet para añadir mensaje nuevo
            .sheet(isPresented: $mostrarAnadir) {
                VistaAnadirMensaje(viewModel: viewModel)
            }
            // Sheet para editar mensaje existente
            .sheet(item: $mensajeEditable) { mensaje in
                VistaAnadirMensaje(viewModel: viewModel, mensajeEditable: mensaje)
            }
        } // NavigationStack
    }
}

#Preview {
    

    VistaMensaje(
        viewModel: MensajeViewModel(idRemitente: 1)
    )
}

/*
import SwiftUI

struct VistaMensaje: View {
    @Bindable var viewModel: MensajeViewModel
    @State private var mostrarAnadir = false
    @State private var mensajeEditable: Mensaje?

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.mensajes, id: \.id) { mensaje in
                    HStack(alignment: .top, spacing: 12) {
                        if let perfil = viewModel.perfilUsuario(id: mensaje.idReceptor) {
                            AsyncImage(url: URL(string: perfil.image)) { img in
                                img.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.perfilUsuario(id: mensaje.idReceptor)?.username ?? "Usuario \(mensaje.idReceptor)")
                                .font(.headline)
                            Text(mensaje.texto)
                                .font(.body)
                            Text(mensaje.fecha, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()
                    }
                    .id(mensaje.id) // evita recrear toda la fila
                    .contentShape(Rectangle())
                    .onTapGesture {
                        mensajeEditable = mensaje
                    }
                }
                .onDelete(perform: viewModel.borrarMensaje)
            }
            .navigationTitle("Mis mensajes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAnadir.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Presentación de sheets corregida
            .sheet(item: $mensajeEditable) { mensaje in
                VistaAnadirMensaje(viewModel: viewModel, mensajeEditable: mensaje)
            }
            .sheet(isPresented: $mostrarAnadir) {
                VistaAnadirMensaje(viewModel: viewModel)
            }
        }
    }
}
#Preview {
    

    VistaMensaje(
        viewModel: MensajeViewModel(idRemitente: 1)
    )
}
*/

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
                    HStack(alignment: .top, spacing: 12) {
                        // Imagen del receptor solo si existe
                        let perfil = viewModel.perfilUsuario(id: mensaje.idReceptor)
                        AsyncImage(url: URL(string: perfil?.image ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(height: 40)
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

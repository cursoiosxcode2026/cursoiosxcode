//
//  VistaMensaje.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 11/3/26.
//

import SwiftUI

struct VistaMensaje: View {
    
    @State private var viewModel:  MensajeViewModel // inicializado
    @State private var mostrarAnadir = false
    @State private var mensajeEditable: Mensaje?
    
    var body: some View {
        NavigationStack {
            List {
                // Usamos $viewModel.mensajes para bindings
                ForEach($viewModel.mensajes) { $mensaje in
                    VStack(alignment: .leading) {
                        Text(mensaje.texto)
                            .font(.headline)
                        Text(mensaje.fecha, style: .date)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .contentShape(Rectangle()) // toda la fila tocable
                    .onTapGesture {
                        mensajeEditable = mensaje
                    }
                }
            .onDelete(perform: viewModel.borrarMensaje)
                }
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


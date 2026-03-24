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
            
            VStack {
                Text("Mensajes")
                    .font(.title2).bold()
                
            }
            
            List {
                ForEach($viewModel.mensajes) { $mensaje in
                    HStack(alignment: .top, spacing: 12) {
                        // Imagen del receptor solo si existe
                        let idOtroUsuario = mensaje.idRemitente == viewModel.idRemitente
                        ? mensaje.idReceptor
                        : mensaje.idRemitente
                        
                        AsyncImage(url: URL(string: viewModel.perfilUsuario(id: idOtroUsuario)?.image ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(height: 50)
                        Spacer()
                        Text(mensaje.texto)
                            .font(.body)
                        Spacer()
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
                .listRowBackground(Color.clear)
               // .listRowSeparator(.hidden)
                
                    // --- ESTO HACE QUE LA RAYA LLEGUE AL BORDE IZQUIERDO ---
                 .alignmentGuide(.listRowSeparatorLeading) { d in
                     d[.leading]
                 }
            }
            }
            //Quita el fondo gris y los bordes redondeados
            .listStyle(.plain)
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
        }
    }

#Preview{
    VistaMensaje(
        viewModel: MensajeViewModel(idRemitente: 1)
    )
}


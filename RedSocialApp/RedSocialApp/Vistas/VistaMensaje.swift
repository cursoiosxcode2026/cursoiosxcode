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
    @State private var mensajeNoEditable: Mensaje?
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Text("Mensajes")
                    .font(.title2).bold()
                
            }
            
            List {
                ForEach($viewModel.mensajes) { $mensaje in
                    HStack(alignment: .top, spacing: 12) {
                        
        
                        //Tiene en cuenta si eres el Remitente o Receptor, si eres remitente devuelve el idReceptor,
                        //Si eres receptor devuelve idRemitente, para que despues cuando se use no devuelva
                        // tu propia imagen de perfil
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
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(mensaje.fecha, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                        //  }
                    }
                    .contentShape(Rectangle())
                    //Asignamos el mensaje dependiendo de si es Editable o no, es Editable cuando el usuario actual es el mismo
                    // que el remitente
                            .onTapGesture {
                                if mensaje.idRemitente == viewModel.idRemitente {
                                    mensajeEditable = mensaje }
                                    else { mensajeNoEditable = mensaje}
                                
                            }
            
                }
                .onDelete(perform: viewModel.borrarMensaje)
                .listRowBackground(Color.clear)
                
                // Hace que la raya llegue desde el borde izquierdo
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
            //Sheet para ver mensaje, no se puede editar porque eres el receptor
            .sheet(item: $mensajeNoEditable) { mensaje in
                VistaVerMensaje(viewModel: viewModel, mensaje: mensaje)
            }
        }
    }

#Preview{
    VistaMensaje(
        viewModel: MensajeViewModel(idRemitente: 1)
    )
}


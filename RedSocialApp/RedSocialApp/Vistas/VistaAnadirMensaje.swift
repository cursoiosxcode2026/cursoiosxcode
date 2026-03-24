//
//  VistaAnadirMensaje.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaAnadirMensaje: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: MensajeViewModel
    var mensajeEditable: Mensaje? = nil
    
    @State private var texto: String = ""
    let idRemitente: Int
    @State private var idReceptor: Int
    
    init(viewModel: MensajeViewModel, mensajeEditable: Mensaje? = nil) {
        self.viewModel = viewModel
        self.mensajeEditable = mensajeEditable
        // Inicializamos el texto si estamos editando
        _texto = State(initialValue: mensajeEditable?.texto ?? "")
        idRemitente = viewModel.idRemitente
        _idReceptor = State(initialValue: mensajeEditable?.idReceptor ?? 1)
        if _idReceptor.wrappedValue == viewModel.idRemitente {
            _idReceptor = State(initialValue: 2) // primer usuario distinto
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Mensaje") {
                    AsyncImage( url: URL(string: viewModel.perfilUsuario(id: idReceptor)?.image ?? "")) { image in
                             image
                                 .resizable()
                                 .scaledToFit()
                         } placeholder: {
                             Color.gray.opacity(0.3)
                         }
                         .frame(height: 50)
                    TextField("Escribe tu mensaje...", text: $texto)
                }
                
                if mensajeEditable == nil {
                    Section("Usuario") {
                        Picker("Selecciona usuario", selection: $idReceptor) {
                            ForEach(1...30, id: \.self) { id in
                                if id != viewModel.idRemitente {
                                    Text("Usuario \(id)").tag(id)
                                }
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
            .navigationTitle(mensajeEditable == nil ? "Nuevo Mensaje" : "Editar Mensaje")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        guardar()
                        dismiss()
                    }
                    .disabled(texto.isEmpty)
               }
            }

        }
    }
    
    func guardar() {
        if let mensaje = mensajeEditable {
            var actualizado = mensaje
            actualizado.texto = texto
         //   actualizado.idUsuario = idUsuario
            viewModel.actualizarMensajes(actualizado)
        } else {
            viewModel.anadirMensaje(texto: texto, idRemitente: idRemitente, idReceptor: idReceptor, fecha: Date())
        }
    }
}

#Preview {
    
    VistaAnadirMensaje(
        viewModel: MensajeViewModel(idRemitente: 1),
        mensajeEditable: nil 
    )
}


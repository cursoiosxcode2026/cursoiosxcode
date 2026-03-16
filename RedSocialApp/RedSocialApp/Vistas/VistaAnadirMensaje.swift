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
    @State private var idUsuario: Int
    
    init(viewModel: MensajeViewModel, mensajeEditable: Mensaje? = nil) {
        self.viewModel = viewModel
        self.mensajeEditable = mensajeEditable
        // Inicializamos el texto si estamos editando
        _texto = State(initialValue: mensajeEditable?.texto ?? "")
        _idUsuario = State(initialValue: mensajeEditable?.idUsuario ?? viewModel.idUsuario)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Mensaje") {
                    TextField("Escribe tu mensaje...", text: $texto)
                }
                
                Section("Usuario") {
                    Picker("Selecciona usuario", selection: $idUsuario) {
                        ForEach(1...30, id: \.self) { id in
                            if id != viewModel.idUsuario { // excluye tu propio ID
                                Text("Usuario \(id)").tag(id)
                            }
                        }
                    }
                    .pickerStyle(.menu)
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
            actualizado.idUsuario = idUsuario
            viewModel.actualizarMensajes(actualizado)
        } else {
            viewModel.anadirMensaje(texto: texto, idUsuario: idUsuario, fecha: Date())
        }
    }
}

#Preview {
    VistaAnadirMensaje(
        viewModel: MensajeViewModel(idUsuario: 1),
        mensajeEditable: Mensaje(id: "1", texto: "Hola mundo", fecha: Date(), idUsuario: 1)
    )
}


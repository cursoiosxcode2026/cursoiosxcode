//
//  VistaVerMensaje.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 25/3/26.
//

import SwiftUI

struct VistaVerMensaje: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: MensajeViewModel
    var mensaje: Mensaje? = nil
    
    @State private var texto: String = ""
    let idRemitente: Int
    @State private var idReceptor: Int
    
    init(viewModel: MensajeViewModel, mensaje: Mensaje? = nil) {
        self.viewModel = viewModel
        self.mensaje = mensaje
        // Inicializamos el texto si estamos editando
        _texto = State(initialValue: mensaje?.texto ?? "")
        idRemitente = viewModel.idRemitente
        _idReceptor = State(initialValue: mensaje?.idReceptor ?? 1)
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
                    
                    Text(texto)
                   
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }

        }
    }
}

#Preview {
    
    VistaVerMensaje(
        viewModel: MensajeViewModel(idRemitente: 1),
        mensaje: nil
    )
}

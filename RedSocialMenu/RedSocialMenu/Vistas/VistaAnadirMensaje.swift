//
//  VistaAnadirMensaje.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 12/3/26.
//

import SwiftUI

struct VistaAnadirMensaje: View {
    @State var viewModel: MensajeViewModel
    var mensajeEditable: Mensaje? = nil
    
    var body: some View {
        VStack {
            Text("Añadir / Editar Mensaje")
            if let mensaje = mensajeEditable {
                Text("Editando: \(mensaje.texto)")
            }
            Button("Cerrar") {
                // Aquí cerrarías el sheet
            }
        }
        .padding()
    }
}

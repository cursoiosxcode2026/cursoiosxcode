//
//  VistaTextInputs.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 21/1/26.
//

import SwiftUI

struct VistaTextInputs: View {
    @State private var nombre: String = ""
    @State private var mensaje = ""
    @State private var password = ""
    @State private var email = ""
    @State private var pin = ""
    @State private var textoEditado = ""
    @FocusState private var mostrarEditor: Bool
    var body: some View {
        VStack {
            Text("Introduce tu nombre")
            TextField("Marcos",text: $nombre)
                .onChange(of: nombre) { oldValue, newValue in
                    print(newValue)
                }
            
            Divider()
            
            
            TextField("Introduce tu mensaje:", text: $mensaje, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5)
                .autocorrectionDisabled(true)
            
            TextField("Introduce tu email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .submitLabel(.continue)
            
            SecureField("Contraseña", text:$password)
            
            TextField("PIN", text: $pin)
                .keyboardType(.decimalPad)
            
            Divider()
            
            Text("Editor de texto")
            
            TextEditor(text: $textoEditado)
                .focused($mostrarEditor)
                .frame(height: 200)
                .border(.black)
            
            Button("Cerrar editor") {
                mostrarEditor = false
            }
            
            Spacer()
                .frame(height: 20)
        }
        
        .padding(.horizontal, 5)
    }
}

#Preview {
    VistaTextInputs()
}

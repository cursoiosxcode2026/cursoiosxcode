//
//  VistaForms.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 21/1/26.
//

import SwiftUI

struct VistaForms: View {
    @State private var nombre = ""
    @State private var email = ""
    @State private var vaAAsistir: Bool = false
    @State private var numeroInvitados: Int = 0
    @State private var alergias = false
    @State private var horaLlegada = Date()
    @State private var textoAlergias  = ""
    var body: some View {
        NavigationStack {
            Form {
                Section("Tus datos personales") {
                    TextField("Nombre completo",text: $nombre)
                    TextField("Correo electrónico",text: $email)
                        .keyboardType(.emailAddress)
                }
                
                Section("Confirmacion") {
                    Toggle("Vas a asistir?",isOn: $vaAAsistir)
                    
                    if vaAAsistir {
                        Group {
                            Stepper(
                                "¿Cuantos acompañantes? \(numeroInvitados)",
                                value: $numeroInvitados,
                                in: 0...5)
                                
                            DatePicker(
                            "Hora de llegada",
                            selection: $horaLlegada,
                            displayedComponents: .hourAndMinute)
                        
                        Toggle("¿Tienes alergias?",isOn: $alergias)
                        }
                    }
                }
            if vaAAsistir && alergias {
                
                Section("Informacion médica") {
                    
                    TextField(
                        "Describe tus alergias",
                        text: $textoAlergias,
                        axis: .vertical)
                    .lineLimit(5)
                }
            }
            
            //Seccion con un boton para darle a enviar
            
            Section {
                Button ("Enviar registro") {
                    print("Enviando datos...")
                }
                .frame(maxWidth: .infinity)
                .disabled(nombre.isEmpty || email.isEmpty)
                
            }
          }
            .navigationTitle("Asiste a la fiesta")
        }
    }
}

#Preview {
    VistaForms()
}

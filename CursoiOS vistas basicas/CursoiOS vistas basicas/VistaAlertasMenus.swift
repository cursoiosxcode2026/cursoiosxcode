//
//  VistaAlertasMenus.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 22/1/26.
//

import SwiftUI

struct VistaAlertasMenus: View {
    @State private var mostrarAlerta = false
    @State private var mostrarActionSheet = false
    @State private var mostraAlertaTextField = false
    @State private var nombre = ""
    @State private var colorRectangulo = Color.black.opacity(0.5)
    var body: some View {
        
        VStack(spacing:10) {
            Button("Mostrar aviso") {
                mostrarAlerta.toggle()
            }
            .alert(isPresented: $mostrarAlerta) {
                Alert(title: Text("Aviso"),
                      message:Text("Esto es un aviso"),
                      dismissButton: .default(Text("Aceptar"))
                )
            }
            
            Button("Mostrar Action Sheet") {
                mostrarActionSheet.toggle()
            }
            .actionSheet(isPresented: $mostrarActionSheet) {
                ActionSheet(
                    title: Text("Escoge como proceder"),
                    message: Text("Puedes aceptar o cancelar"),
                    buttons: [
                        .default(Text("Aceptar cambios")) { aceptar() },
                        .destructive(Text("Rechazar cambios")) { rechazar()},
                        .cancel(Text("Cancelar")) {} //El boton cancel no es visible en iOS 26
                    ]
                )
            }
            
            //Alerta con un textfield para introducir datos
            Button("Toca para introducir tu nombre") {
                mostraAlertaTextField.toggle()
            }
            .alert("Datos", isPresented: $mostraAlertaTextField) {
                TextField("Nombre",text: $nombre)
                Button("Aceptar") {
                    print("Introdujo su nombre: \(nombre)")
                    nombre = "" //Lo dejo vacio por si el usuario quiere volver a introducir el nombre //de nuevo
                }
            }
            message: {
                Text("Introduce tu nombre para confirmar")
            }
            
            //Menu contextual (para colorear el rectangulo de abajo
            Label(
                "Haz long press (mantener apretado) para menu contextual",
                systemImage: "button.horizontal.top.press")
            
            .foregroundStyle(Color.accentColor)
            .contextMenu {
                Button {
                    colorRectangulo = .red
                } label: {
                    Label("Colorea de rojo", systemImage: "paintbrush")
                }
                
                Button {
                    colorRectangulo = .green
                } label: {
                    Label ("Colorea de verde",systemImage: "leaf")
                }
            }
            
            Rectangle()
                .fill(colorRectangulo)
                .frame(width: 50, height: 50)
            
            Menu("Toca para ver opciones") {
                Button("Editar",systemImage: "pencil") {
                    //codigo para editar
                    
                }
                Button("Duplicar",systemImage: "plus.square.on.square") {
                    //codigo para duplicar
                    
                }
                
                Divider() //podemos poner separadores para visualizar y separar botones
                
                Button("Eliminar",systemImage: "trash", role:.destructive) {
                    //codigo para eliminar
                    
                }
            }
            .menuOrder(.fixed)
        }
    }
    
    func aceptar() {
        
        print("Aceptado")
    }
    
    func rechazar() {
        print("Rechazado")
    }
}

#Preview {
    VistaAlertasMenus()
}

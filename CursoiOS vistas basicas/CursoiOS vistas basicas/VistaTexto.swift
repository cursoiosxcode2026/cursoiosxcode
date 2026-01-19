//
//  VistaTexto.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 19/1/26.
//

import SwiftUI

struct VistaTexto: View {
    let frase = "Hola, esta es una frase normal"
    let titulo = "Título"
    let parrafo = "Este es un parrafo mas largo que puede contener muchas lineas y caracteres. Lo vamos a alargar para que ocupe unas cuantas lineas.Este es un parrafo mas largo que puede contener muchas lineas y caracteres. Lo vamos a alargar para que ocupe unas cuantas lineas."
    
    var body: some View {
        VStack(spacing: 5) {
            Text(frase)
            
            Text(parrafo)
                .lineLimit(3)
                .multilineTextAlignment(.center) //alinea el texto en el centro
            
            Text (titulo)
                .font(.largeTitle)
            Text(titulo)
                .font(.title)
            Text(titulo)
                .font(.title2)
            Text(titulo)
                .font(.caption)
            Text(titulo)
                .font(.footnote)
            
            //Cambiar tamaño y el 'weight'
            
            Text(titulo)
                .font(.system(size: 25)).fontWeight(.light)
            
            //Cambiar la fuente referncia: https://developer.apple.com/fonts/system-fonts/
            Text(frase)
                .font(.custom("Gill Sans Bold", size: 23))
            
            //Cambiar el color del texto
            Text(frase)
                .foregroundColor(.brown)
            
            Text(frase)
                .foregroundStyle(Color(red: 0.98, green: 0.62, blue: 0.05))
            
            Text(frase)
                .foregroundStyle(Color(hue: 0.21, saturation: 0.75, brightness: 0.6, opacity: 0.6))
            
            Text("Frase con negrita, cursiva, subrayado, tachado").bold() //negrita
                .italic() //cursiva
                .underline(color: .blue) //subrayado (opcional cambiar el color)
                .strikethrough() //tachado (opcional cambiar el color)
            
            Text("Texto con bordes")
                .padding()
                .border(Color.black, width: 3) //width es opcional
            
            //Vista Label
            Label("Etiqueta con imagen",systemImage: "flag.2.crossed.fill")
            //.labelStyle(.iconOnly)
            
            //Label personalizada
            Label {
                Text("Otra etiqueta")
                    .font(.title)
                    .bold()
            }icon:{
                Image(systemName: "sun.horizon.fill")
                    .background(.red)
                    .opacity(0.5)
                
            }
            .padding(5)
            .background(Color(red: 0.3, green: 0.2, blue: 0.9, opacity: 0.15))
            .border(Color.blue,width: 2)
        }
    }
}

#Preview {
    VistaTexto()
}



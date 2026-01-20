//
//  VistaPrueba.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 20/1/26.
//

import SwiftUI

struct VistaPruebas: View {
    var body: some View {
        
        VStack (spacing: 20){
            
            
            HStack {
                Text("Hola, qué tal?")
                    .font(.title2)
                
                Image("bd")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
            
            
            HStack {
                Text ("Hoy es: ")
                    .font(.title)
                
                Image("martes")
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            
            HStack {
                Image(systemName: "cat")
                Text("🌼")
                Image(systemName: "dog.fill")
                Text("🌹")
                Image(systemName: "dog")
                Text("🌸")
                Image(systemName: "cat.fill")
                Text("🌺")
            }
            .background(.white.opacity(0.5))
            
            ZStack {
                Circle()
                    .fill(.pink.opacity(0.5))
                    .frame(width: 120)
                Text("💐")
                    .font(.system(size: 100))
                    
            }
            
            VStack {
               Text("Loren ipsum sit dolor amet consectetur adipisicing elit. Quisquam, aspernatur! Loren ipsum sit dolor amet consectetur adipisicing ")
                    .font(.custom("Gill Sans Bold", size: 7))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    
                    
            }
            .background(.white)
            
            VStack {
                Text("Aquí esta el padding")
                    .padding(10)
                    .shadow(color: .white, radius:9)
                    .background(.blue)
                
                
                Rectangle()
                    .frame(width: 40,height: 20).opacity(0.2)
                
                Text("Arriba está el rectangulo")
                    .underline()
                    .bold()
                    .foregroundColor(.red)
                
            }
            .background(.green.opacity(0.2))
            
            
            HStack {
                Image("corazonazul")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70,height: 70)
                
                Text("Corazón azul")
                    
                    
            }
            .padding(10)
            .border(.white, width: 4)
            
            ZStack {
                
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 250, height: 40)
                
                HStack {
                    
                    Image(systemName: "capsule")
                    Text("Pulsa aquí")
                        .foregroundStyle(.white)
                }
            
            }
            .padding(20)
    
            
        }
        .background(.blue.opacity(0.15))
    }
}

#Preview {
    VistaPruebas()
}

//
//  VistaTarjeta.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 23/1/26.
//

import SwiftUI

struct VistaScrollHorizontal: View {
    //VistaTarjeta(numero: 0)
    var body: some View {
        VStack (alignment: .leading) {
            Text("Categorias")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            ScrollView(.horizontal,showsIndicators: false) {
                
                HStack(spacing: 20) {
                    ForEach(0..<5) { indice in
                        VistaTarjeta(numero: indice)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.vertical,5)
            }
        }
        
    }
    
}
struct VistaTarjeta: View {
    let numero: Int
    let colores: [Color] = [.red, .blue, .yellow, .green, .brown]
    var body: some View {
        VStack {
            Text("Nivel \(numero + 1)")
                .font(.headline)
                .foregroundStyle(.white)
            
            Spacer()
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
        }
        .padding()
        .frame(width: 150,height: 200)
        .background(colores[numero % colores.count])
        .cornerRadius(20)
        .shadow(radius: 4, x:3, y:4)
    }
}
    

#Preview {
    VistaScrollHorizontal()
}

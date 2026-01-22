//
//  VistaTarjetaFavoritos.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 22/1/26.
//

import SwiftUI

struct VistaTarjetaFavoritos: View {
    var body: some View {
        VStack (spacing: 10){
            TarjetaFavorito(imagen: "pajarito", texto:"Es un pajarito", puntuacion: "3.5")
            TarjetaFavorito(imagen: "gatito",texto:"Es un gatito",puntuacion: "4.8")
            
        }
        .padding(.horizontal)
    }
}

struct TarjetaFavorito:  View {
    var imagen: String
    var texto: String
    var puntuacion: String
 @State private var esFavorito = false
    var body: some View {
        HStack (spacing: 15) {
            Image(imagen)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        //Textos
            VStack(alignment: .leading,spacing: 5) {
                Text(texto)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.brown)
                
                HStack (spacing: 4){
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                        .font(.caption)
                    
                    Text(puntuacion)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
                Text("Creado for cutie cute®")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Image(systemName: esFavorito ? "heart.fill": "heart")
                .foregroundStyle(.red)
                .font(.title3)
                .onTapGesture {
                    
                    esFavorito.toggle()
                }
        }
        
        .padding(15)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    VistaTarjetaFavoritos()
}

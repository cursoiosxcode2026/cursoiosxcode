//
//  Perfil.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct Perfil: Identifiable {
    let id = UUID()
    let nombre: String
    let titulo: String
    let descripcion: String
    let reels: String
    let seguidores: String
    let seguidos: String
    
    @State private var siguiendo = false
    @State private var imagenActiva: Int? = nil
    @State private var ampliarPerfil = false
    
    func editarImagenUsuario (imagen: String) -> some View {
        Image(imagen)
            .resizable()
            .foregroundStyle(.gray.opacity(0.3))
            .frame(width: 120,height: 120)
            .clipShape(Circle())
            .scaleEffect(ampliarPerfil ? 1.5 : 1)
            .animation(.default, value: ampliarPerfil)
            .onTapGesture {
                ampliarPerfil.toggle()
            }
    }
    
    func nombreUsuario (nombre: String) -> some View{
        Text(nombre)
            .font(.title)
            .fontWeight(.bold)
    }
    
    func tituloUsuario(titulo: String, imagen: String)-> some View{
        Label (titulo, systemImage: imagen)
            .font(.headline)
            .foregroundStyle(.blue)
    }
    
    func descripcionUsuario(descripcion: String) -> some View{
        Text(descripcion)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .padding(.horizontal)
    }
    
  
      func infoNumeros(numero: String, texto: String) -> some View {
          VStack {
              Text (numero)
                  .font(.title2)
                  .bold()
              Text(texto)
                  .font(.caption)
              
          }
        
    }
    
    func subirContenido (imagen : String, index : Int) -> some View {
        
        Image(imagen)
            .resizable()
            .foregroundStyle(.gray.opacity(0.3))
            .frame(width: 120,height: 120)
            .clipShape(Rectangle())
            .scaleEffect(imagenActiva == index ? 1.75 : 1)
            .animation(.default, value: imagenActiva)
            .onTapGesture {
                imagenActiva = (imagenActiva == index) ? nil : index
            }
    
    }
    
    
}

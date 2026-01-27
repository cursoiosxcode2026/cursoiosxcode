//
//  VistaSeguidores.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI

struct VistaSeguidores: View {
    @State private var siguiendo = false
    @State private var enviarMensaje = false
    let seguidor : Seguidores
    
    init(seguidor: Seguidores) {
        self.seguidor = seguidor
    }
    
    
    
    
    var body: some View {
        VStack(spacing:20) {
            //Seccion imagen de perfil
            
            ZStack {
                Circle()
                    .stroke(Color.blue,lineWidth: 3)
                    .frame(width: 130, height: 130)
                
                
                //Imagen del Usuario
                editarImagenUsuario(imagen: "paris")
    
            }
            .padding(.top,20)
            
            //Seccion de informacion
            VStack(spacing: 8) {
              nombreUsuario(nombre: "Paloma Vaquero Tirado")
              tituloUsuario(titulo: "UGC Spain", imagen: "video.bubble")
              descripcionUsuario(descripcion: "Creadora de contenido, ideas y momentos del día a día.")
                
            }
            
            Divider()
                .padding(.horizontal,10)
            
            //Seccion numeros
            HStack {
                infoNumeros(numero: "25", texto: "Reels")
                Spacer()
                infoNumeros(numero: "15k", texto: "Seguidores")
                Spacer()
                infoNumeros(numero: "4k", texto: "Seguidos")
            }
            .padding(.horizontal, 40)
            
            //Seccion botones
            
            HStack (spacing: 15){
                Button {
                    siguiendo.toggle()
                } label: {
                    Text(siguiendo ? "Siguiendo" : "Seguir")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(siguiendo ? Color.gray : Color.blue)
                        .clipShape(Capsule())
                }
                Button {
                    enviarMensaje.toggle()
                } label: {
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundStyle(enviarMensaje ? Color.green : Color.red)
                        .padding()
                        .background(
                           // enviarMensaje ? Color.green : Color.red
                           Capsule() //Con stroke se hace hueca
                              .stroke(enviarMensaje ? Color.green : Color.red,lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom,20)
            
            VStack {
                
                HStack {
                    subirContenido(imagen: "pajarito")
                    subirContenido(imagen: "paris")
                    subirContenido(imagen: "gatito")
                }
                
                HStack {
                    subirContenido(imagen: "gatito")
                    subirContenido(imagen: "pajarito")
                    subirContenido(imagen: "paris")
                    
                }
                HStack {
                    subirContenido(imagen: "paris")
                    subirContenido(imagen: "gatito")
                    subirContenido(imagen: "pajarito")
                    
                    
                }
            }
        }
        Spacer()
    }
    
    func editarImagenUsuario (imagen: String) -> some View {
        Image(imagen)
            .resizable()
            .foregroundStyle(.gray.opacity(0.3))
            .frame(width: 120,height: 120)
            .clipShape(Circle())
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
    
    func subirContenido (imagen : String) -> some View {
        Image(imagen)
            .resizable()
            .foregroundStyle(.gray.opacity(0.3))
            .frame(width: 120,height: 120)
            .clipShape(Rectangle())
        
    }
        
        
        
    }

#Preview {
    VistaSeguidores(seguidor: Seguidores(nombre:"Paloma",seguidores:"15k"))
}

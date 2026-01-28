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
    @State private var imagenActiva: Int? = nil
    
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
                nombreUsuario(nombre: seguidor.nombre)
                tituloUsuario(titulo: seguidor.titulo, imagen: "video.bubble")
                descripcionUsuario(descripcion: seguidor.descripcion)
                
            }
            
            Divider()
                .padding(.horizontal,10)
            
            //Seccion numeros
            HStack {
                infoNumeros(numero: seguidor.reels, texto: "Reels")
                Spacer()
                infoNumeros(numero: seguidor.seguidores, texto: "Seguidores")
                Spacer()
                infoNumeros(numero: seguidor.seguidos, texto: "Seguidos")
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
                    subirContenido(imagen: "pajarito", index: 0)
                    subirContenido(imagen: "paris", index: 1)
                    subirContenido(imagen: "gatito",index: 2 )
                }
                
                HStack {
        
                    subirContenido(imagen: "paris", index: 3)
                    subirContenido(imagen: "gatito",index: 4 )
                    subirContenido(imagen: "pajarito", index: 5)
                    
                }
                HStack {
                    subirContenido(imagen: "gatito",index: 6)
                    subirContenido(imagen: "pajarito", index: 7)
                    subirContenido(imagen: "paris", index: 8)
                    
                    
                }
            }
            Spacer()
        }
        
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
    
   /* func ampliarPortada(imagen:String) -> some View {
        
        Image(systemName: imagen)
            .font(.system(size: 60))
            .foregroundStyle(.green)
            .scaleEffect(ampliame ? 1.75 : 1)
            .animation(.default, value: ampliame)
            .onTapGesture {
                ampliame.toggle()
            }
    }*/
        
        
        
    }

#Preview {
    VistaSeguidores(seguidor: Seguidores(nombre: "Paloma", titulo: "UGC Spain", descripcion: "Creadora de contenido, ideas y momentos del día a día.", reels: "25", seguidores: "15k",seguidos: "4k"))
}

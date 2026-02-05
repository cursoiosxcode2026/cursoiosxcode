//
//  VistaPerfil.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct VisitarPerfil: View {
    @Environment(RedSocial.self) var redSocial
    @State private var siguiendo = false
    @State private var enviarMensaje = false
    @State private var imagenActiva: Int? = nil
    @State private var ampliarPerfil = false

    
    var body: some View {
        VStack(spacing:10) {
            //Seccion imagen de perfil
            
            ZStack {
                Circle()
                    .stroke(Color.blue,lineWidth: 3)
                    .frame(width: 130, height: 130)
                
                
                //Imagen del Usuario
                redSocial.perfil.editarImagenUsuario(imagen: "paris")
    
            }
            .padding(.top,20)
            
            //Seccion de informacion
            VStack(spacing: 8) {
                redSocial.perfil.nombreUsuario(nombre: redSocial.perfil.nombre)
                redSocial.perfil.tituloUsuario(titulo: redSocial.perfil.titulo, imagen: "video.bubble")
                redSocial.perfil.descripcionUsuario(descripcion: redSocial.perfil.descripcion)
                
            }
            
            Divider()
                .padding(.horizontal,10)
            
            //Seccion numeros
            HStack {
                redSocial.perfil.infoNumeros(numero: redSocial.perfil.reels, texto: "Reels")
                Spacer()
                redSocial.perfil.infoNumeros(numero: redSocial.perfil.seguidores, texto: "Seguidores")
                Spacer()
                redSocial.perfil.infoNumeros(numero: redSocial.perfil.seguidos, texto: "Seguidos")
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
                    redSocial.perfil.subirContenido(imagen: "pajarito", index: 0)
                    redSocial.perfil.subirContenido(imagen: "paris", index: 1)
                    redSocial.perfil.subirContenido(imagen: "gatito",index: 2 )
                }
                
                HStack {
        
                    redSocial.perfil.subirContenido(imagen: "paris", index: 3)
                    redSocial.perfil.subirContenido(imagen: "gatito",index: 4 )
                    redSocial.perfil.subirContenido(imagen: "pajarito", index: 5)
                    
                }
                HStack {
                    redSocial.perfil.subirContenido(imagen: "gatito",index: 6)
                    redSocial.perfil.subirContenido(imagen: "pajarito", index: 7)
                    redSocial.perfil.subirContenido(imagen: "paris", index: 8)
                    
                    
                }
            }
            Spacer()
            
        }
        
    }

}

#Preview {
    
   
    VisitarPerfil()
        .environment(RedSocial())
}

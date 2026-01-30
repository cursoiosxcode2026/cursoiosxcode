//
//  VistaPerfil.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct VistaPerfil: View {
    @Binding var perfil: Perfil
   
   

    
    var body: some View {
        VStack(spacing:10) {
            //Seccion imagen de perfil
            
            ZStack {
                Circle()
                    .stroke(Color.blue,lineWidth: 3)
                    .frame(width: 130, height: 130)
                
                
                //Imagen del Usuario
                perfil.editarImagenUsuario(imagen: "paris")
    
            }
            .padding(.top,20)
            
            //Seccion de informacion
            VStack(spacing: 8) {
                perfil.nombreUsuario(nombre: perfil.nombre)
                perfil.tituloUsuario(titulo: perfil.titulo, imagen: "video.bubble")
                perfil.descripcionUsuario(descripcion: perfil.descripcion)
                
            }
            
            Divider()
                .padding(.horizontal,10)
            
            //Seccion numeros
            HStack {
                perfil.infoNumeros(numero: perfil.reels, texto: "Reels")
                Spacer()
                perfil.infoNumeros(numero: perfil.seguidores, texto: "Seguidores")
                Spacer()
                perfil.infoNumeros(numero: perfil.seguidos, texto: "Seguidos")
            }
            .padding(.horizontal, 40)
            
            
            VStack {
                
                HStack {
                    perfil.subirContenido(imagen: "pajarito", index: 0)
                    perfil.subirContenido(imagen: "paris", index: 1)
                    perfil.subirContenido(imagen: "gatito",index: 2 )
                }
                
                HStack {
        
                    perfil.subirContenido(imagen: "paris", index: 3)
                    perfil.subirContenido(imagen: "gatito",index: 4 )
                    perfil.subirContenido(imagen: "pajarito", index: 5)
                    
                }
                HStack {
                    perfil.subirContenido(imagen: "gatito",index: 6)
                    perfil.subirContenido(imagen: "pajarito", index: 7)
                    perfil.subirContenido(imagen: "paris", index: 8)
                    
                    
                }
            }
            Spacer()
            
        }
        
    }

}

#Preview {
    
    @Previewable @State var perfil: Perfil = Perfil(nombre: "Paloma", titulo: "UGC Spain", descripcion: "Creadora de contenido, ideas y momentos del día a día.", reels: "25", seguidores: "15k",seguidos: "4k")
    VistaPerfil(perfil: $perfil)
}

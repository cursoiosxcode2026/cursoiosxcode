//
//  VistaTarjetaPerfit.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 22/1/26.
//

import SwiftUI

struct VistaTarjetaPerfil: View {
    var body: some View {
        VStack(spacing:20) {
            //Seccion imagen de perfil
            
            ZStack {
                Circle()
                    .stroke(Color.blue,lineWidth: 3)
                    .frame(width: 130, height: 130)
                
                //Imagen de perfil
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundStyle(.gray.opacity(0.3))
                    .frame(width: 120,height: 120)
            }
            .padding(.top,20)
            
            //Seccion de informacion
            VStack(spacing: 8) {
                Text("Laura García")
                    .font(.title)
                    .fontWeight(.bold)
                
                Label ("Desarrolladora Swift", systemImage: "swift")
                    .font(.headline)
                    .foregroundStyle(.orange)
                
                
                Text("Apasionada por el desarrollo de aplicaciones para iPhone, iPad y Mac en general")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
            }
            
            Divider()
                .padding(.horizontal,10)
            
            //Seccion estadisticas
            HStack {
                VStack {
                    Text("25")
                        .font(.title2)
                        .bold()
                    Text("Proyectos")
                        .font(.caption)
                }
                Spacer()
                
                VStack {
                    
                    Text("1.2k")
                        .font(.title2)
                        .bold()
                    Text("Seguidores")
                        .font(.caption)
                }
                Spacer()
                
                VStack {
                   Text("4,9 ⭐️ ")
                    .font(.title2).bold()
                   Text("Rating")
                    .font(.caption)
                    
                }
                
            }
            .padding(.horizontal,40)
            
            //Seccion botones
            
            HStack (spacing: 15){
                Button {
                    print("Siguiendo...")
                } label: {
                    Text("Seguir")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                Button {
                    print("Enviando mensaje...")
                } label: {
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .padding()
                        .background(
                            Capsule() //Con stroke se hace hueca
                                .stroke(.red,lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom,20)
        }
    }
}

#Preview {
    VistaTarjetaPerfil()
}

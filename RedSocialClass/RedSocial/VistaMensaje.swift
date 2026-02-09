//
//  VistaMensajes.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct VistaMensaje: View {
    @State private var mensajes: [Mensaje] = (1...10).map { _ in Mensaje() }
    
    var body: some View {
        
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading) {
                    
                    LazyVStack(spacing: 10) {
                        
                        ForEach(mensajes, id: \.id) { mensaje in
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.blue.gradient)
                                .frame(height: 80)
                                .padding(5)
                                .overlay (
                                    VStack{
                                        Text(mensaje.emisor.nombre)
                                        .foregroundStyle(.white)
                                        .bold()
                                        
                                        Text(mensaje.mensajeAbreviado)
                                            .foregroundStyle(.black.opacity(0.75))
                                            .bold()
                                    
                        }
                                )
                                .onAppear {
                                    print("Cargando Mensaje \(mensaje.id)")
                                }
                        }
                    }
                    
                    .padding(.vertical)
                    
                }
                
            }
            .navigationTitle(Text("Mensajes"))
        }
        
    }
}
        
#Preview {

    VistaMensaje()
}

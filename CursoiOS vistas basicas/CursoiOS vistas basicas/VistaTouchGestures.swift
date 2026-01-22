//
//  VistaTouchGestures.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 22/1/26.
//

import SwiftUI

struct VistaTouchGestures: View {
    let alto = 100.0
    
    @State private var puntoDeToque : CGPoint = CGPoint(x:0, y: 50)
    
    @State private var mensajePulsando = ""
    
    @State private var pinchTemporal : CGFloat = 0
    @State private var pinchFinal : CGFloat = 1
    
    @State private var posicionCirculo = CGPoint(x:50, y: 50)
    
    
    var toqueEspacial: some Gesture {
        SpatialTapGesture(count: 1)  // 1 para 1 tap, 2 para doble tap,etc
            .onEnded { evento in
                puntoDeToque = evento.location
            }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Hazme tap")
                .background(.green)
                .onTapGesture {
                    print("Has hecho tap!")
                }
            
            Text("Hazme doble tap")
                .background(.blue)
                .onTapGesture(count: 2) {
                    print("Has hecho doble tap!")
                }
            ZStack {
                Rectangle()
                    .fill(.red.opacity(0.3))
                    .frame(width: 210,height: 120)
                    .onTapGesture {
                        print("Tap sobre el rectangulo")
                    }
                
                Text("Haz tap sobre el rectangulo")
            }
            
            Rectangle()
                .foregroundStyle(.purple.opacity(puntoDeToque.y / alto))
                .frame(width: 150,height: alto)
                .gesture(toqueEspacial)
            
            Text("Presioname durante 1 segundo")
                .padding()
                .background(Color.mint)
                .onLongPressGesture(minimumDuration: 1.0, pressing: { estaPulsando in
                    if estaPulsando {
                        mensajePulsando = "Está pulsando!"
                    } else {
                        mensajePulsando = "Ya soltó el press"
                    }
                    
                }) {
                    //Esto se ejecuta cuando pasa el minimumDuration
                    mensajePulsando = "Ya hizo el long press"
                    
                }
            Text(mensajePulsando)
                .frame(width: 250, height: 25)
                .background(.yellow)
            
            Image(systemName: "star.fill")
                .font(.system(size: 100))
                .foregroundStyle(.cyan)
                .scaleEffect(pinchFinal + pinchTemporal)
                .gesture (
                    MagnificationGesture()
                        .onChanged { delta in
                            pinchTemporal = delta - 1
                        }
                        .onEnded { _ in
                            pinchFinal += pinchTemporal
                            pinchTemporal = 0
                        }

                )
            
            Circle()
                .fill(Color.brown)
                .frame(width: 100, height: 100)
                .position(posicionCirculo)
                .gesture(DragGesture()
                    .onChanged { posicion in
                        posicionCirculo.x = posicion.location.x
                        posicionCirculo.y = posicion.location.y
                    }
                    .onEnded { _ in
                        //Al soltarlo vuelve a dejarlo en su sitio original
                        posicionCirculo = CGPoint(x: 50, y: 50)
                    }
                )
        }
    }
}

#Preview {
    VistaTouchGestures()
}

//
//  VistaAnimaciones.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 28/1/26.
//

import SwiftUI

struct VistaAnimaciones: View {
    @State private var mueveme = false
    @State private var ampliame = false
    @State private var animame = false
    var body: some View {
        VStack(spacing: 15) {
            Image("pajarito")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
            
                //En este caso, CGSize se usa como vector de distancia
            //no como medidas de tamaño. Por lo tanto, admite valores negativos. EJ.
            //CGSize(width: -50, height: -100)
                .offset(mueveme ? CGSize(width :100, height: 0) : CGSize(width:-100, height: 0))
            //easinf functions: https://www.svgator.com/blog/easing-functions/
            //easeIn, easeOut, easeInOut, bouncy(rebota), etc
            // .animation(.default, value: mueveme)
                .animation(.bouncy(duration: 0.6,extraBounce: 0.2), value: mueveme)
            
            Button("Toca para mover el pajarito") {
                mueveme.toggle()
            }
            
            Image(systemName: "tortoise.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
                .scaleEffect(ampliame ? 1.75 : 1)
                .animation(.default, value: ampliame)
                .onTapGesture {
                    ampliame.toggle()
                }
            
            HStack {
                RoundedRectangle(cornerRadius: animame ? 100 : 50)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(animame ? .red : .yellow)
                    .scaleEffect(animame ? 1.25 : 1)
                    .rotationEffect(animame ? .degrees(360) : .zero)
                    .opacity(animame ? 0.5 : 1)
                    .animation(.easeInOut(duration: 0.8).delay(0.25), value: animame)
                    .onTapGesture {
                        animame.toggle()
                    }
                
                
                RoundedRectangle(cornerRadius: animame ? 100 : 50)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(animame ? .red : .yellow)
                    .scaleEffect(animame ? 1.25 : 1)
                    .rotationEffect(animame ? .degrees(360) : .zero)
                    .opacity(animame ? 0.5 : 1)
                    .onTapGesture {
                        withAnimation (.easeInOut(duration: 0.8).delay(0.25)) {
                            animame.toggle()
                        }
                        
                    }
            }
            
            Button("Anima ambos rectangulos y la tortuga") {
                withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                    animame.toggle()
                }
                
                withAnimation(.default) {
                    ampliame.toggle()
                }
            }
            
            RoundedRectangle (cornerRadius: animame ? 100 : 50)
                .modifier(RectanguloAnimable(animame: $animame))
                .onTapGesture {
                    withAnimation(.easeIn(duration:0.7)) {
                        animame.toggle()
                    }
                }
        }
    }
}


struct RectanguloAnimable: ViewModifier {
    @Binding var animame: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 150)
            .foregroundStyle(animame ? .red : .yellow)
            .scaleEffect(animame ? 1.25 : 1)
            .rotationEffect(animame ? .degrees(360) : .zero)
            .opacity(animame ? 0.5 : 1)
        
    }
    
}
#Preview {
    VistaAnimaciones()
}

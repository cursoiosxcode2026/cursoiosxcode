//
//  VistaLazyHStack.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 9/2/26.
//

import SwiftUI

struct VistaLazyHStack: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Recomendados para ti")
                    .font(.title)
                    .padding(.horizontal)
                
                ScrollView(.horizontal,showsIndicators: false) {
                    
                    LazyHStack(spacing: 20) {
                        
                        ForEach(1...50, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.purple.gradient)
                                .frame(width: 150, height: 200)
                                .overlay (
                                    Text("Peli \(index)")
                                        .foregroundStyle(.white)
                                        .bold()
                                )
                                .onAppear {
                                    print("Cargando Peli \(index)")
                                }
                        }
                    }
                    
                    .padding(.horizontal)
                    .frame(height:220)
                }
                
                Text("Contenido familiar")
                    .font(.title)
                    .padding(.horizontal)

                ScrollView(.horizontal,showsIndicators: false) {
                    
                    LazyHStack(spacing: 20) {
                        
                        ForEach(1...50, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.purple.gradient)
                                .frame(width: 150, height: 200)
                                .overlay (
                                    Text("Peli \(index)")
                                        .foregroundStyle(.white)
                                        .bold()
                                )
                                .onAppear {
                                    print("Cargando Peli \(index)")
                                }
                        }
                    }
                    
                    .padding(.horizontal)
                    .frame(height:220)
                }
            }
        }
    }
}

#Preview {
    VistaLazyHStack()
}

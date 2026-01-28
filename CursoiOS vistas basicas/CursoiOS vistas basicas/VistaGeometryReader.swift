//
//  VistaGeometryReader.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 28/1/26.
//

import SwiftUI

struct VistaGeometryReader: View {
    var body: some View {
        VStack (spacing : 10) {
            Text("Un geometry reader debajo ⬇️")
            Spacer().frame(minHeight: 50, maxHeight: 100)
            //La vista GeometryReader coge TODO el espacio posible que se le deje
            GeometryReader { geometry in
                
                VStack {
                    Text("Ancho del GR: \(geometry.size.width)")
                    Text("Alto del GR \(geometry.size.height)")
                    Text("Coordenadas absolutas: \(geometry.frame(in: .global).origin)")
                    
                    
                    Rectangle()
                        .fill(.green)
                        .frame(width: geometry.size.width * 0.5, height: 100)
                        .position(x: geometry.size.width / 4, y: geometry.size.height / 3)
                }
            }
            
            .background(.blue.opacity(0.25))
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: geometry.size.width * 0.75)
                    Rectangle()
                        .fill(.blue)
                        .frame(width: geometry.size.width * 0.25)
                    
                    
                }
            }
            .frame(height: 150)
            .background(.red.opacity(0.25))
        }
    }
}

#Preview {
    VistaGeometryReader()
}

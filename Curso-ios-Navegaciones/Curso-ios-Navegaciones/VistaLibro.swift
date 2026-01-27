//
//  VistaLibro.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI

struct VistaLibro: View {
    let libro: Libro
    
    init(_ libro: Libro) {
        self.libro = libro
    }
    var body: some View {
        VStack(spacing: 20) {
            Text(libro.titulo)
                .font(.largeTitle)
            
            
            Label {
                Text(libro.autor)
                    .font(.body)
                    .fontWeight(.light)
            } icon: {
                Image(systemName: "pencil")
            }
        }
    }
}

#Preview {
    VistaLibro(Libro(titulo: "Don Quijote", autor:"Cervantes"))
}

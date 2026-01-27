//
//  VistaListaNavegable.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI

struct Libro: Identifiable, Hashable {
    let id = UUID()
    let titulo: String
    let autor: String
}


struct VistaListaNavegable: View {
    let libros = [
        Libro(titulo: "Don Quijote", autor: "Cervantes"),
        Libro(titulo: "Guerra y Paz", autor: "Dostoyevsky"),
        Libro(titulo: "Recetas tiktokeras", autor: "Cristina Pedroche"),
    ]
    
    var body: some View {
        
        NavigationStack  {
            
            List(libros) { libro in
                NavigationLink("\(libro.titulo)", value: libro)
            }
            
            .navigationTitle("Lista de libros")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationDestination(for: Libro.self) { libro in
                VistaLibro(libro)
            }
        }
    }
}

#Preview {
    VistaListaNavegable()
}

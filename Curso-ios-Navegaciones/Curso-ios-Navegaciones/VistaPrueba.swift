//
//  VistaPrueba.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI

struct Seguidores: Identifiable, Hashable {
    let id = UUID()
    let nombre: String
    let seguidores: String
}

struct VistaPrueba: View {
    
    let seguidores = [
        Seguidores(nombre: "Paloma", seguidores: "15k"),
        Seguidores(nombre: "Álvaro", seguidores: "4,5k"),
        Seguidores(nombre: "Cristina", seguidores: "9k"),
        Seguidores(nombre: "Yoana", seguidores: "2k"),
    ]
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 20) {
                List(seguidores) { seguidor in
                    NavigationLink("\(seguidor.nombre)", value: seguidor)
                }
                
                .navigationTitle("Seguidores")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationDestination(for: Seguidores.self) { seguidor in
                    VistaSeguidores(seguidor: seguidor)
                }
            }
        }
    }
}
        

#Preview {
    VistaPrueba()
}

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
    let titulo: String
    let descripcion: String
    let reels: String
    let seguidores: String
    let seguidos: String
}

struct VistaPrueba: View {
    
    let seguidores = [
        Seguidores(nombre: "Paloma", titulo: "UGC Spain", descripcion: "Creadora de contenido, ideas y momentos del día a día.", reels: "25", seguidores: "15k",seguidos: "4k"),
        Seguidores(nombre: "Álvaro", titulo: "Big Data", descripcion: "Big data department ECI", reels: "120", seguidores: "3.5k",seguidos: "2k"),
        Seguidores(nombre: "Cristina", titulo: "UGC Spain", descripcion: "Adicta a la fotografía", reels: "302", seguidores: "9k",seguidos: "2.4k"),
        Seguidores(nombre: "Yoana", titulo: "Nails", descripcion: "Haciendo uñas bonitas desde 2018", reels: "190", seguidores: "3k",seguidos: "1k"),
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

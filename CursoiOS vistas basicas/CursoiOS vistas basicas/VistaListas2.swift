//
//  VistaListas2.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 23/1/26.
//

import SwiftUI

struct VistaListas2: View {
    
    @State private var animalBuscar = ""
    
    let arrayAnimalesInicial = [
        "Gato", "Pajaro", "Pez", "Perro", "Araña", "Hamster", "Pato",
    ]
    @State private var arrayAnimales: [String]
    
    init() {
        arrayAnimales = arrayAnimalesInicial
    }
    
    var body: some View {
        Text("Animales disponibles: \(arrayAnimales.count)")
        
        List {
            ForEach(arrayAnimales, id: \.self) { animal in
                Text(animal)
            }
            .onDelete(perform: borrar)
            .onMove(perform: mover)
            
        }
        
        .searchable(text: $animalBuscar)
        .onChange(of: animalBuscar) { oldValue, textoBusqueda in
            if !textoBusqueda.isEmpty {
                arrayAnimales = arrayAnimalesInicial
                arrayAnimales = arrayAnimales.filter {
                    // $0.lowercased().contains(textoBusqueda.lowercased())
                    //Opcion para que encuentre los que empiecen con
                    $0.lowercased().starts(with: textoBusqueda.lowercased())
                }
            } else {
                arrayAnimales = arrayAnimalesInicial
            }
        }
    }
    
    func borrar(at posicion: IndexSet) {
        arrayAnimales.remove(atOffsets: posicion)
//        print(arrayAnimales)
        
    }
    func mover(_ origen: IndexSet, _ destino: Int) {
        arrayAnimales.move(fromOffsets: origen, toOffset: destino)
 //       print(arrayAnimales)
    }
}

#Preview {
    VistaListas2()
}

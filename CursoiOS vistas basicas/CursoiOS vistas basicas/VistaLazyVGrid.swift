//
//  VistaLazyGrid.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 9/2/26.
//

import SwiftUI

struct VistaLazyVGrid: View {
    
    //Definimos columnas adaptables: ancho/alto mínimo 100 y que entren las que quepan
    
    let columnas = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    
    var body: some View {
        
        NavigationView {
            
            //Necesitamos ScrollView porque los Lazy Grids no scrollean por si solos
            ScrollView {
                LazyVGrid(columns: columnas, spacing: 10) {
                    ForEach(1...500, id: \.self) { index in
                        
                        VStack {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                            Text("Foto \(index)")
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(.indigo.opacity(0.2))
                        .cornerRadius(10)
                        
                        //Se llama antes de que aparezca la vista por pantalla
                        .onAppear {
                            print("Cargando foto \(index)")
                        }
                        //Se llama cuando la vista desaparece del area visible
                        .onDisappear {
                            print("Ocultando foto \(index)")
                        }
                        
                    }
                }
                .padding()
            }
            
            .navigationTitle(Text("Galería Lazy"))
        }
       
    }
}

#Preview {
    VistaLazyVGrid()
}

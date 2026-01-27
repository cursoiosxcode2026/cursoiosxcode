//
//  VistaTabs.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI

struct VistaTabs: View {
    @State private var vistaSeleccionada: Int = 0
    
    var body: some View {
        
       let _ = print(vistaSeleccionada)
        
        TabView(selection: $vistaSeleccionada) {
                VistaFavoritos(vistaSeleccionada: $vistaSeleccionada)
                .tabItem {
                 Image(systemName: "heart.fill")
                 Text("Favs")
            }.tag(0)
            
            Text("Vista redacción")
                .tabItem {
                    Image(systemName: "pencil.and.scribble")
                    Text("Redactar")
                }.tag(1)
            
            Text("Vista Imprimir")
                .tabItem {
                    Image(systemName: "printer.filled.and.paper")
                }.tag(2)
            
            Text("Vista carpetas")
                .tabItem {
                    Label("Carpetas",systemImage: "folder.fill")
                }.tag(3)
        }
        .accentColor(.pink)
    }
}
    
    struct VistaFavoritos : View {
        @Binding var vistaSeleccionada: Int
        var body: some View {
            VStack {
                Text("Vista favoritos")
                Button("Ir a vistas carpetas") {
                    vistaSeleccionada = 3
                }
            }
        }
    }

#Preview {
    VistaTabs()
}

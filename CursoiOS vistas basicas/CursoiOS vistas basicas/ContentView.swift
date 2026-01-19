//
//  ContentView.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 19/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationStack  {
          ScrollView {
              VStack(spacing: 20) {
                  NavigationLink(destination: VistaPaddings()) {
                      Text("Ir a vista de paddings")
                  }
                  NavigationLink(destination: VistaTexto()) {
                      Text("Ir a vista de textos")
                  }
                  NavigationLink(destination: VistaStacks()) {
                      Text("Ir a vista de Stacks")
                  }
                  NavigationLink(destination:VistaImagenes()) {
                      Text("Ir a vista de Imágenes")
                  }
                  
              }
            }
          
        }
    }
}

#Preview {
    ContentView()
}

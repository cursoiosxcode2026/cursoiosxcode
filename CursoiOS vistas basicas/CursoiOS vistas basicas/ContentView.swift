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
                  NavigationLink(destination: VistaPruebas()){
                      Text("Ir a vista de pruebas")
                  }
                  
                  NavigationLink(destination: VistaBotones()) {
                      Text("Ir a vista de botones")
                  }
                  NavigationLink(destination: VistaTextInputs()) {
                      Text ("Ir a vista de insercion de texto")
                  }
                  NavigationLink(destination: VistaTogglesSliders()) {
                      Text("Ir a vista de Toggles, Steppers, Sliders")
                  }
                  NavigationLink(destination: VistaForms()) {
                      Text("Ir a vista de formlularios")
                  }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

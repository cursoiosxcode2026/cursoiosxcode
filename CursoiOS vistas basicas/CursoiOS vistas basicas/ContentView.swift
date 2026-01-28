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
                  
                  NavigationLink(destination:VistaAlertasMenus()){
                      Text("Ir a vista de Alertas y Menús")
                  }
                  NavigationLink(destination: VistaTouchGestures()) {
                      Text("Ir a vista de toques")
                  }
                  
                  NavigationLink(destination: VistaTarjetaPerfil()) {
                      Text("Ir a vista de tarjeta de perfil")
                  }
                  NavigationLink(destination: VistaTarjetaFavoritos()) {
                      Text("Ir a vista de tarjeta de favoritos")
                  }
                  
                  NavigationLink(destination: VistaPruebas2()){
                      Text("Ir a vista de pruebas2")
                  }
                  NavigationLink(destination: VistaScrollHorizontal()){
                      Text("Ir a vista de scroll horizontal ")
                  }
                  
                  NavigationLink(destination: VistaListas()){
                      Text("Ir a vista de listas ")
                  }
                  NavigationLink(destination: VistaListas2()){
                      Text("Ir a vista de listas2 ")
                  }
                  
                  NavigationLink(destination: VistaExtensionesVistas()){
                      Text("Ir a vista extensiones vistas ")
                  }
                  
                  
                  NavigationLink(destination: VistaAnimaciones()){
                      Text("Ir a vista animaciones ")
                  }
                  
                  NavigationLink(destination: VistaGeometryReader()){
                      Text("Ir a vista geometry reader ")
                  }
                  
                  NavigationLink(destination: VistaDebugging()){
                      Text("Ir a vista debugging ")
                  }
                }

            }
        }
    }
}

#Preview {
    ContentView()
}

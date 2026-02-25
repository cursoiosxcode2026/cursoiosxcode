//
//  ContentView.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                NavigationLink(destination: VistaConCicloDeVida()) {
                    Text("Vista con ciclo de vida")
                }
                NavigationLink(destination: VistaPhotoPicker()) {
                    Text("Photo picker")
                }
                NavigationLink(destination: VistaCompartir()) {
                    Text("Compartir")
                }
                NavigationLink(destination: VistaMapa()) {
                    Text("Mapa")
                }
                NavigationLink(destination: VistaTipKit()) {
                    Text("TipKit")
                }
                NavigationLink(destination: VistaHaptics()) {
                    Text("Haptics")
                }
                NavigationLink(destination: VistaConectividad()) {
                    Text("Conectividad a red")
                }
                NavigationLink(destination: VistaSonidos()) {
                    Text("Sonidos")
                }
                NavigationLink(destination: VistaWebViewSimple()) {
                    Text("Webview simple")
                }
                NavigationLink(destination: VistaWebKit()) {
                    Text("Webview con WebKit")
                }
                
                NavigationLink(destination: VistaFicheros()) {
                    Text("Ir a ficheros")
                }
                
                /*Launch Screen
                -Ir a configuracion en Target > Info.
                -Añadir a clave Launch Screen (con el +)
                -Dentro configurar:
                    - Image Name
                    - Background Color
                
                 */
                
                NavigationLink(destination: VistaThemes()) {
                    Text("Ir a Temas")
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}

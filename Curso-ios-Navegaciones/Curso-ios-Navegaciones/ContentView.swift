//
//  ContentView.swift
//  Curso-ios-Navegaciones
//
//  Created by Equipo 7 on 27/1/26.
//

import SwiftUI
import LoremSwiftum
import SwiftUINavigationTransitions

struct ContentView: View {
    var parrafo = Lorem.words(10)
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: Text("Contenido de la Vista 1")) {
                Text("Ir a vista 1")
            }
            
            NavigationLink {
                //Este es el destination 2
                Text("Esta es la vista 2")
            } label: {
                Text("Ir a vista 2")
                    .font(.largeTitle)
            }
            
            NavigationLink(destination: OtraVista()) {
                Text("Ir a otra vista")
            }
            
            NavigationLink(destination: VistaListaNavegable()) {
                Text("Ir a vista de lista navegable")
            }
            
            NavigationLink(destination: VistaPrueba()) {
                Text("Ir a vista prueba")
            }
            
            //Poner al final del NavigationStack, pero dentro de las llaves
            .navigationTitle("Menu navegable")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("Me has pulsado")
                    } label: {
                        Text("Pulsa")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Vamos a la nube")
                    } label: {
                        Image(systemName: "icloud")
                    }
                }
            }
        }
        .accentColor(.purple)
        //libreria
        //https://github.com/davdroman/swiftui-navigation-transitions
        //.navigationTransition(.slide(axis:.vertical))
  
        .navigationTransition(.fade(.in).animation(.easeInOut(duration:0.3)))
        
    }
}

struct OtraVista: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("Una vista mas grande")
                Spacer()
            }
            Spacer()
        }.background(.yellow)
    }
}
#Preview {
    ContentView()
}

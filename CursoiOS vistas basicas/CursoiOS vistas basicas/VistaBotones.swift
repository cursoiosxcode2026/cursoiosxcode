//
//  VistaBotones.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 20/1/26.
//

import SwiftUI
enum MenuSize: String, CaseIterable, Identifiable {
    case small = "Pequeño"
    case medium = "Mediano"
    case large = "Grande"
    case extraLarge = "Gigante"
    
    var id: String { self.rawValue }
    
}

struct VistaBotones: View {
    @State private var activado = false
    @State private var selectedItem =  ""
    @State private var menuSize: MenuSize = .medium
    var body: some View {
        
        VStack {
            
            Button ("Hazme clic / tap") {
                //Entre las llaves esta el codigo que
                // ejecuta al tocar el boton
                print("Me has hecho clic")
            }
            
            Button {
                print("Me has hecho tap")
            } label: {
                Text("Hazme clic")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding()
                    .background(.green)
            }
            
            Button {
                print("Has tocado el boton con label")
            } label: {
                Label("Hazme tap!",systemImage: "pointer.arrow.click")
                    .padding()
                    .border(Color.blue,width: 2)
            }
            
            Button {
                print("Has tocado la imagen")
            } label: {
                Image("pajarito")
                    .resizable()
                    .frame(width:50,height:50)
                    .clipShape(Circle())
            }
            
            Text("El switch está " + (activado ? "activado" : "desactivado"))
            
            Button {
                activado.toggle()
                print("Activado = \(activado)")
            } label: {
                Label("Toca para activar/desactivar el switch", systemImage: "pointer.arrow")
                    .padding()
                    .border(Color.blue)
            }
            
            Divider()
            
            Picker("Selecciona tu menú", selection: $selectedItem) {
                Text("Elijo Carne").tag("Carne")
                Text("Elijo Pescado").tag("Pescado")
                Text("Elijo Vegetal").tag("Vegetal")
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedItem) { valorAnterior, valorNuevo in
                print("Estaba seleccionado \(valorAnterior) y ahora has seleccionado \(valorNuevo)")
            }
            
            Text("Está seleccionado el menu: \(selectedItem)")
            
            Divider()
            
            HStack {
                Text("De tamaño de bebida, quiero:")
                Picker("Selecciona el tamaño",selection: $menuSize) {
                    ForEach(MenuSize.allCases) { tamano in
                        Text(tamano.rawValue).tag(tamano)
                    }
                }
                .onChange(of: menuSize) { oldValue, newValue in
                    switch newValue {
                    case .small, .medium:
                        print("La moderacion es importante")
                    case .large:
                        print("Bebe con moderacion")
                    case .extraLarge:
                        print("Diabetes")
                    }
                }
            }
        }
        
    }
}

#Preview {
    VistaBotones()
}

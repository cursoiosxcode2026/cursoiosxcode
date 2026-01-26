//
//  VistaExtensionesVistas.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 26/1/26.
//

import SwiftUI

struct VistaExtensionesVistas: View {
    
    @State private var estaResaltado = false
    var body: some View {
       Text("Hola!")
            .estilo1()
        
        Button("Un boton") {}
            .botonGrande()
        
        Button("Otro boton de color negro") {}
            .modifier(BotonModifier(color: .black))
        
        //Este codigo hace lo mismo que el de arriba pero usando
        //la extension
        Button("Boton de color rojo") {}
            .estiloColorBoton(color: .red)
        
        Text("Activame")
            .toggleColoreable()
        
        Divider()
        
        //Ejemplo para ViewModifiers con estado que se le pasa desde
        //la vista principal
        
        Text("Texto con bordes resaltables")
            .bordeModificado(activado: $estaResaltado)
        
       //     .modifier(ModificadorBordes(activado: $estaResaltado))
            
            
        
        Button("Cambiar borde") {
            estaResaltado.toggle()
        }
        .estiloColorBoton(color: .green)
        
    }
}

//Extendemos la FUNCIONALIDAD de las vistas.
extension View {
    func estilo1() -> some View {
     self
            .foregroundStyle(.indigo)
            .bold()
            .font(.title3)
            .italic()
    }
    
    func botonGrande() -> some View {
        self
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}

struct BotonModifier: ViewModifier {
    
    let color: Color
    
    //Content es la referencia a la vista
    func body(content: Content) -> some View {
        content //aqui usamos content en vez de self
            .padding(12)
            .background(color)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
    
}

extension View {
    func estiloColorBoton(color: Color = .blue) -> some View {
        self.modifier(BotonModifier(color : color))
    }
}

//ViewModifiers con @State
extension View {
    func toggleColoreable () -> some View {
        self.modifier(ToggleColoreable())
    }
}

struct ToggleColoreable: ViewModifier {
    @State var activado: Bool = false
    
    func body(content: Content) -> some View {
        Toggle(isOn: $activado) {
            content
                .foregroundStyle(activado ? .red : .primary)
        }
        .padding()
        
    }
}

//ViewModifier con un parametro que recibimos (Binding)
struct ModificadorBordes: ViewModifier {
    //'activado' va a ser el estado que recibimos desde fuera
    
    @Binding var activado: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .border(activado ? .red : .gray, width: 2)
            .background(activado ? .red.opacity(0.5) : .white)
    }
}

extension View {
    
    func bordeModificado (activado : Binding<Bool>) -> some View {
        self.modifier(ModificadorBordes(activado: activado))
    }
}


#Preview {
    VistaExtensionesVistas()
    
}

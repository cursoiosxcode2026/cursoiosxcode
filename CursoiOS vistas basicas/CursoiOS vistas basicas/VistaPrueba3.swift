//
//  VistaPrueba3.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 26/1/26.
//

import SwiftUI

struct VistaPrueba3: View {
    @State var isActive: Bool = false
    var body: some View {
        
        
        VStack {
            
            Text("Texto  que cambia su fondo")
                .cambioFondo(activado: $isActive)
            
            
            Button("Cambiar fondo") {
                isActive.toggle()
            }
            
            
        }
    }
}
    struct CambioFondo: ViewModifier {
        //'activado' va a ser el estado que recibimos desde fuera
        
        @Binding var activado: Bool
        func body(content: Content) -> some View {
            content
                .padding()
                .border(activado ? .green : .red, width: 2)
                .background(activado ? .blue : .white)
        }
    }

extension View {
    
    func cambioFondo (activado : Binding<Bool>) -> some View {
        self.modifier(ModificadorBordes(activado: activado))
    }
    
}

#Preview {
    VistaPrueba3()
}

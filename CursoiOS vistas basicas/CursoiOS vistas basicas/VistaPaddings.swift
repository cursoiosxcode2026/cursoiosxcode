//
//  VistaPaddings.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 19/1/26.
//

import SwiftUI

struct VistaPaddings: View {
    var body: some View {
        Text("Hola. Esta es mi primera app iOS")
        Text("Otro texto")
        
        Text("Texto con padding")
            .padding()
            .background(Color.blue)
        
        Text("Padding de 20 puntos")
            .padding(20)
            .background(Color.green)
        
        Text("Padding en top (arriba")
            .padding(.top, 10)
            .background(Color.yellow)
        
        Text("Padding en bottom(abajo")
            .padding(.bottom, 10)
            .background(Color.yellow)
        
        Text("Padding vertical (arriba y abajo")
            .padding(.vertical,10)
            .background(Color.yellow)
        
        Text("Padding a la izquierda")
            .padding(.leading)
            .background(Color.orange)
        
        Text("Padding a la derecha")
            .padding(.trailing)
            .background(Color.orange)
        
        Text("Padding horizontal(izquierda y derecha)")
            .padding(.horizontal)
            .background(Color.orange)
        
        Text("Multipading")
            .padding([.top,.leading],20)
            .background(Color.red)
    }
}


#Preview {
    VistaPaddings()
}

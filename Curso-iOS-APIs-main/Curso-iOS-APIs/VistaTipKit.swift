//
//  VistaTipKit.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import TipKit

struct TipFavorito: Tip {
    var title: Text { Text("Guardar favoritos") }
    var message: Text? { Text("Pulsa aquí para guardar este elemento.") }
    var image: Image? { Image(systemName: "star") }
}

// --> Para que funcione, es necesario configurarlo en la App <--

struct VistaTipKit: View {
    let tipFavorito = TipFavorito()
    
    var body: some View {
        VStack {
            Image(systemName: "star")
                .font(.largeTitle)
                .popoverTip(tipFavorito) // Poner este código para mostrar el tip
                .onTapGesture {
                    tipFavorito.invalidate(reason: .actionPerformed)
                }
        }
        // En caso de que no funcione en el Canvas:
//        .task {
//            try? Tips.configure()
//        }
    }
}

#Preview {
    VistaTipKit()
}

//
//  VistaThemes.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 7 on 25/2/26.
//

import SwiftUI

struct AppTheme {
    let fondo = Color(.colorFondo)
    let accion = Color(.colorAccion)
    let exito = Color.indigo
}

extension Color {
        static let theme = AppTheme()
    }


struct VistaThemes: View {
    var body: some View {
        ZStack {
            Color.theme.fondo
                .ignoresSafeArea()
            
            VStack {
                Button("Confirmar") {}
                    .padding()
                    .background(Color.theme.accion)
                    .foregroundStyle(.white)
                
                Text("Operacion exitosa")
                    .foregroundStyle(Color.theme.exito)
            }
        }
    }
}

#Preview {
    VistaThemes()
}

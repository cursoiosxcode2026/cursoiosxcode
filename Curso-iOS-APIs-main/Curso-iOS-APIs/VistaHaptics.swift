//
//  VistaHaptics.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI

struct VistaHaptics: View {
    @State private var contador = 0
    @State private var errorTrigger = false
    
    var body: some View {
        Button("Incrementar: \(contador)") {
            contador += 1
        }
        // Vibra cada vez que cambie 'contador'
        .sensoryFeedback(.impact(weight: .medium, intensity: 1.0), trigger: contador)
        
        Button("Simular error") {
            errorTrigger.toggle()
        }
        .sensoryFeedback(.error, trigger: errorTrigger)
    }
}

#Preview {
    VistaHaptics()
}

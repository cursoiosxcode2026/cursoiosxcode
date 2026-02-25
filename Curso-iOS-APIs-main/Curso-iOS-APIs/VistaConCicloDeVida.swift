//
//  VistaConCicloDeVida.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI

struct VistaConCicloDeVida: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Observamos cambios en la app")
            .onChange(of: scenePhase) { oldValue, newValue in
                switch newValue {
                case .active:
                    print("App activa")
                case .inactive:
                    print("App inactiva (ej. centro de control)")
                case .background:
                    print("App en segundo plano (Home pulsado o cambio de app)")
                default:
                    break
                }
            }
    }
}

#Preview {
    VistaConCicloDeVida()
}

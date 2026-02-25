//
//  VistaConectividad.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import Network

@Observable
class NetworkMonitor {
    var conectado = true
    var conexionPorDatos = false
    var conexionPorWifi = false
    
    private let monitor = NWPathMonitor()
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.conectado = path.status == .satisfied
            self.conexionPorDatos = path.usesInterfaceType(.cellular)
            self.conexionPorWifi = path.usesInterfaceType(.wifi)
        }
        monitor.start(queue: DispatchQueue.global())
    }
}

struct VistaConectividad: View {
    @State private var network = NetworkMonitor()

    var body: some View {
        ContentUnavailableView(
            "Estado de red",
            systemImage: network.conectado ? "wifi" : "wifi.slash",
            description: Text(network.conectado ? "Estás conectado" : "Sin conexión")
        )
    }
}

#Preview {
    VistaConectividad()
}

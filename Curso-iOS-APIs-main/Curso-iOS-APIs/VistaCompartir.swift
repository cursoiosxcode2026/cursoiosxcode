//
//  VistaCompartir.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI

struct VistaCompartir: View {
    private let url = URL(string: "https://www.apple.com")!
    private let miFoto = Image("foto1")
    
    var body: some View {
        VStack(spacing: 20) {
            // Compartir URL
            ShareLink(item: url) {
                Label("Compartir enlace", systemImage: "square.and.arrow.up")
            }
            
            // Compartir texto con asunto
            ShareLink(
                item: "Mira mis notas",
                subject: Text("Asunto importante"),
                message: Text("Cuerpo del mensaje.Bla bla bla. Te cuento que blabllaba")
            )
            
            // Se puede compartir cualquier cosa que implemente el protocolo Transferable.
            // Por defecto lo incorporan: String, URL, Image, Data, Codable
            ShareLink(
                item: miFoto,
                preview: SharePreview("Mi foto increíble", image: miFoto)
            ) {
                Label("Compartir foto", systemImage: "photo")
            }
        }
    }
}

#Preview {
    VistaCompartir()
}

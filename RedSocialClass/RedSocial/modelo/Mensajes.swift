//
//  Mensajes.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI
import Observation

@Observable
class Mensaje {
    let id = UUID()
    let emisor: Perfil
    let mensajeAbreviado: String
    
    init() {
        self.emisor = Perfil(nombre: "Juan Pérez",
                             titulo: "Creador de contenido",
                             descripcion: "Amante de los viajes y la fotografía",
                             reels: "1300",
                             seguidores: "12k",
                             seguidos: "3k")
        self.mensajeAbreviado = "Esto es un mensaje de prueba"
    }
    
    deinit {
      print("Quitando la instancia mensaje")
        
    }
}


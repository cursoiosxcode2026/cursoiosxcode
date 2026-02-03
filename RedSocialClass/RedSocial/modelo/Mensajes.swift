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
        self.emisor = Perfil()
        self.mensajeAbreviado = ""
    }
    
    deinit {
      print("Quitando la instancia mensaje")
        
    }
}


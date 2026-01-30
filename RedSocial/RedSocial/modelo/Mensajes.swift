//
//  Mensajes.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI

struct Mensajes: Identifiable {
    let id = UUID()
    let emisor: Perfil
    let mensajeAbreviado: String
}


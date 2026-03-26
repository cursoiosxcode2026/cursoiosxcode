//
//  Perfil.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import Foundation

struct Perfil: Codable, Identifiable, Hashable {
    let id: Int
    let username: String
    let password: String?
    let image: String
    let company: Company?

}

struct Company: Codable, Hashable {
    let title: String
}

struct PerfilDetalle: Codable, Identifiable {
    let id: Int
    let username: String
    let password: String?
    let image: String
    
    let company: Company?
    let email: String
    let phone: String
    var post: [String] = []  
    var mensajes: [Mensaje] = []
    
}



//La API nos devuelve los personajes en un array de usuarios,
//dado que la API contiene el objeto "results"
struct RespuestaAPI: Codable {
    let users: [Perfil]
    
}


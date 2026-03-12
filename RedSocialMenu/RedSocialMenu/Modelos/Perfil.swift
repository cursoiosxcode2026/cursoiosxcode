//
//  Modelo.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
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
   //  var titulo: String?
    let image: String
    
    let company: Company?
    let email: String
    let phone: String
    var post: [String] = []  // posts simulados
    var mensajes: [Mensaje] = []  
    
}



//La API nos devuelve los personajes en un array de Personajes,
//dado que la API contiene el objeto "results"
struct RespuestaAPI: Codable {
    let users: [Perfil]
    
} 

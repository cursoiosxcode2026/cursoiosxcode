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
    let password: String
    var titulo: String
    let image: String
    let company: Company?
    
    
    struct Company: Codable, Hashable, Equatable {
        let title: String
    }
}

struct PerfilDetalle: Codable, Identifiable {
    let id: Int
    let username: String
    let password: String
    var titulo: String
    let image: String
    
    let email: String
    let phone: String
    var post: [String] = []  // posts simulados
    
}

struct Post: Codable, Identifiable {
    let id: Int
    let name: String
    let air_date: String
}

//La API nos devuelve los personajes en un array de Personajes,
//dado que la API contiene el objeto "results"
struct RespuestaAPI: Codable {
    let users: [Perfil]
    
}

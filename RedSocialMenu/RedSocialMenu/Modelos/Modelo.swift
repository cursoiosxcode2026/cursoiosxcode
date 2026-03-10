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
    
    //var titulo: String?
    
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
    
    //var titulo: String?

    let email: String
    let phone: String
    var post: [String] = []  // posts simulados
    
}

struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let body: String
    let reactions: Reactions
    let air_date: String
    var image: String = ""
    
    struct Reactions: Codable, Hashable {
        let likes: Int
        let dislikes: Int
    }
    
    var likes: Int { reactions.likes }
    var dislikes: Int { reactions.dislikes }
    
    
}

//La API nos devuelve los personajes en un array de Personajes,
//dado que la API contiene el objeto "results"
struct RespuestaAPI: Codable {
    let users: [Perfil]
    
}

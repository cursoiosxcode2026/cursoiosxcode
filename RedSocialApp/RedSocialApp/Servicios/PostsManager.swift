//
//  PostsManager.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 23/3/26.
//

import Foundation

class PostsManager {
    
    static let shared = PostsManager()
    
    private init() {}
    
    private let apiService = ApiService.instancia
    
    private var postsPorPerfil: [Int: [Post]] = [:]

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    func obtenerPosts(perfilId: Int) async throws -> [Post] {
        
        //Si ya están en cache los devuelve
        if let posts = postsPorPerfil[perfilId] {
            return ordenar(posts)
        }
        
        // Si no los pide a la API
        let nuevosPosts = try await apiService.obtenerPostsAleatorios(
            cantidad: Int.random(in: 1...30)
        )
        
        // Los guarda en cache
        postsPorPerfil[perfilId] = nuevosPosts
        return ordenar(nuevosPosts)
    }
    
    //Obtiene los post para la tab Feed
    func obtenerPostFeed() async throws -> [Post] {
        
        let nuevosPostsFeed = try await apiService.obtenerPostsAleatorios(
            cantidad: Int.random(in: 1...30)
        )
        
        return ordenar(nuevosPostsFeed)
    }
    
    
    //Ordena los post por fecha
    private func ordenar(_ posts: [Post]) -> [Post] {
        posts.sorted {
            convertirFecha($0.air_date) > convertirFecha($1.air_date)
        }
    }
    
    //Convierte la fecha
    private func convertirFecha(_ fechaString: String) -> Date {
        return Self.formatter.date(from: fechaString) ?? Date.distantPast
    }
}

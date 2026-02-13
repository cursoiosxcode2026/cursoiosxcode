//
//  DetallePersonajeViewModel.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 13/2/26.
//
/*import SwiftUI
import Observation

@Observable
class DetallePerfilViewModel {
    let perfil: Perfil
    var detalle: PerfilDetalle?
    var post: [Post] = []
    var perfilesRelacionados: [Perfil] = []
    
    var isLoading = true
    
    private let apiService: ApiService
    
    init(perfil: Perfil, apiService: ApiService = ApiService.instancia) {
        self.perfil = perfil
        self.apiService = apiService
    }
    
    
    func cargarDatosCompletos() async {
        do {
            let datosDetalle = try await apiService.obtenerDetallePersonaje(id: perfil.id)
            self.detalle = datosDetalle
            
            if !datosDetalle.post.isEmpty {
                self.post = try await apiService.obtenerPosts(urls: datosDetalle.post)
                print("Post cargados: \(post.count)")
            }
            
            if !post.isEmpty {
                try await cargarPerfilesRelacionados()
            }
            
            isLoading = false
            
        } catch {
            print("Error cargando detalles del perfil \(error)")
        }
    }
    
    func cargarPerfilesRelacionados() async throws {
        var urlsPerfiles: Set<String> = Set()
        
        for post in post {
            
            for perfilUrl in post.name {
                urlsPerfiles.insert(perfilUrl)
            }
        }
    
        let ids: [Int] = urlsPerfiles.compactMap { urlString in
            guard let idString = urlString.split(separator: "/").last else { return nil }
            return Int(idString)
        }
            .filter { id in
              //Quitamos al perfil actual (self.perfil) de la lista:
                return id != perfil.id
            }
        
        //Limitamos el número de personajes que solicitamos al mostrar
        //Ademas usamos shuffled() para que nos devuelva una lista aleatoria
        let idsLimitados = Array(ids.shuffled().prefix(10))
    
        self.perfilesRelacionados = try await apiService.obtenerPerfilesPorIds(ids: idsLimitados)
        
    
        print("Cargados \(self.perfilesRelacionados.count) perfiles relacionados.")
    }
}

*/

import SwiftUI
import Observation

@Observable
class DetallePerfilViewModel {
    let perfil: Perfil
    var detalle: PerfilDetalle?
    var post: [Post] = []
    var perfilesRelacionados: [Perfil] = []
    
    var isLoading = true
    
    private let apiService: ApiService
    
    init(perfil: Perfil, apiService: ApiService = ApiService.instancia) {
        self.perfil = perfil
        self.apiService = apiService
    }
    
    func cargarDatosCompletos() async {
        do {
            var detalle = try await apiService.obtenerDetallePersonaje(id: perfil.id)
            
            // Simulamos posts
            self.post = detalle.post.enumerated().map {
                Post(id: $0.offset, name: $0.element, air_date: "2026-02-13")
            }
            
            self.detalle = detalle
            
            // Simulamos perfiles relacionados
            let idsRelacionados = Array(1...20).shuffled().filter { $0 != perfil.id }.prefix(10)
            self.perfilesRelacionados = try await apiService.obtenerPerfilesPorIds(ids: Array(idsRelacionados))
            
            await MainActor.run { self.isLoading = false }
            
        } catch {
            print("Error cargando detalle: \(error)")
            await MainActor.run { self.isLoading = false }
        }
    }
}


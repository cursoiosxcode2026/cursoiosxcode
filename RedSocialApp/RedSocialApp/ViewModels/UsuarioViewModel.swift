//
//  UsuarioViewModel.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 18/3/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
class UsuarioViewModel {
    var usuarioActual: Perfil? = nil
    var perfiles: [Perfil] = []
    var postsPorPerfil: [Int: [Post]] = [:]
    
    var isLoading = false
    var errorMessage: String? = nil

    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiService.instancia) {
        self.apiService = apiService
    }
    
  /*  func cargarPostsParaPerfil(_ perfil: Perfil) async throws -> [Post] {
        if let postsGuardados = postsPorPerfil[perfil.id] {
            // Si ya hay posts guardados, los devolvemos
            return postsGuardados
        } else {
            // Si no hay, generamos posts aleatorios y los guardamos
            let posts = try await apiService.obtenerPostsAleatorios(cantidad: Int.random(in: 1...30))
            postsPorPerfil[perfil.id] = posts
            return posts
        }
    } */
    
    func cargarPostsParaPerfil(_ perfil: Perfil) async throws -> [Post] {
        if let postsGuardados = postsPorPerfil[perfil.id] {
            return postsGuardados.sorted {
                convertirFecha($0.air_date) > convertirFecha($1.air_date) // más recientes primero
            }
        } else {
            let posts = try await apiService.obtenerPostsAleatorios(cantidad: Int.random(in: 1...30))
            postsPorPerfil[perfil.id] = posts
            return posts.sorted {
                convertirFecha($0.air_date) > convertirFecha($1.air_date)
            }
        }
    }
    
    
    
    
    
    // Convierte "13 Feb 2026" a Date
    private func convertirFecha(_ fechaString: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES") // meses en español
        formatter.dateFormat = "dd MMM yyyy"          // ejemplo: "13 Feb 2026"
        
        return formatter.date(from: fechaString) ?? Date.distantPast
    }
    func cargarDatos() async {
        await MainActor.run { isLoading = true }
        do {
            let perfiles = try await apiService.obtenerPerfiles()
            await MainActor.run {
                self.perfiles = perfiles
                self.errorMessage = nil
                print("en seguidores view model")
            }
        } catch {
            await MainActor.run { errorMessage = "No se pudieron cargar los perfiles" }
            print("❌ ERROR EN VIEWMODEL:", error)
        }
        
        
        await MainActor.run { isLoading = false }
    }
    
    func cerrarSesion() {
        usuarioActual = nil
    }
}


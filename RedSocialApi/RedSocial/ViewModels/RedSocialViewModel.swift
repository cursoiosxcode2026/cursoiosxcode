//
//  VistaRickAndMortyViewModel.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 13/2/26.
//
import SwiftUI
import Observation

@Observable
class RedSocialViewModel {
    var perfiles: [Perfil] = []
    var postsPorPerfil: [Int: [Post]] = [:]
    
    var isLoading = false
    var errorMessage: String? = nil

    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiService.instancia) {
        self.apiService = apiService
    }
    
    func cargarPostsParaPerfil(_ perfil: Perfil) async throws -> [Post] {
        if let postsGuardados = postsPorPerfil[perfil.id] {
            // Si ya hay posts guardados, los devolvemos
            return postsGuardados
        } else {
            // Si no hay, generamos posts aleatorios y los guardamos
            let posts = try await apiService.obtenerPostsAleatorios(cantidad: Int.random(in: 1...30))
            postsPorPerfil[perfil.id] = posts
            return posts
        }
    }
    func cargarDatos() async {
        await MainActor.run { isLoading = true }
        do {
            let perfiles = try await apiService.obtenerPerfiles()
            await MainActor.run {
                self.perfiles = perfiles
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run { errorMessage = "No se pudieron cargar los perfiles" }
            print("❌ ERROR EN VIEWMODEL:", error)
        }
        
        
        await MainActor.run { isLoading = false }
    }
}


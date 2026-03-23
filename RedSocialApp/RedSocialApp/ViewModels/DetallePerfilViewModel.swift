//
//  DetallePerfilViewModel.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI
import Observation

@Observable
class DetallePerfilViewModel {
    let perfil: Perfil
    var detalle: PerfilDetalle?
    var post: [Post] = []
    var perfilesRelacionados: [Perfil] = []
    var isLoading = true
    var titulo: String {
        detalle?.company?.title ?? perfil.company?.title ?? "Sin título"
    }
    private let apiService: ApiService
    var postsPorPerfil: [Int: [Post]] = [:]
    
    init(perfil: Perfil, apiService: ApiService = ApiService.instancia) {
        self.perfil = perfil
        self.apiService = apiService
        
    }
    
    func cargarDatosCompletos() async {
        do {
            let detalle = try await apiService.obtenerDetallePerfil(id: perfil.id)
            
            self.post = try await PostsManager.shared.obtenerPosts(perfilId: perfil.id)
            
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



//
//  DetallePersonajeViewModel.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 13/2/26.
//
import SwiftUI
import Observation

@Observable
class DetallePerfilViewModel {
    let perfil: Perfil
    var detalle: PerfilDetalle?
    var post: [Post] = []
    var perfilesRelacionados: [Perfil] = []
    let viewModel : SeguidoresSeguidosViewModel
    var isLoading = true
    var titulo: String {
        detalle?.company?.title ?? perfil.company?.title ?? "Sin título"
    }
    private let apiService: ApiService
    
    init(perfil: Perfil, viewModel: SeguidoresSeguidosViewModel, apiService: ApiService = ApiService.instancia) {
        self.perfil = perfil
        self.viewModel = viewModel
        self.apiService = apiService
        
    }
    
    func cargarDatosCompletos() async {
        do {
            let detalle = try await apiService.obtenerDetallePerfil(id: perfil.id)
            
            // Simulamos posts
           /* self.post = detalle.post.enumerated().map {
                Post(id: $0.offset, name: $0.element, air_date: "2026-02-13")
            }
            let cantidadAleatoria = Int.random(in: 1...30)
            self.post = try await apiService.obtenerPostsAleatorios(cantidad: cantidadAleatoria )
            */
            self.post = try await viewModel.cargarPostsParaPerfil(perfil)
            
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


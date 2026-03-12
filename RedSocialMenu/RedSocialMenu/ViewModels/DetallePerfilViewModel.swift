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
 //   let viewModel : SeguidoresSeguidosViewModel
    var isLoading = true
    var titulo: String {
        detalle?.company?.title ?? perfil.company?.title ?? "Sin título"
    }
    private let apiService: ApiService
    var postsPorPerfil: [Int: [Post]] = [:]
    
    init(perfil: Perfil/*, viewModel: SeguidoresSeguidosViewModel*/, apiService: ApiService = ApiService.instancia) {
        self.perfil = perfil
      //  self.viewModel = viewModel
        self.apiService = apiService
        
    }
    
    func cargarDatosCompletos() async {
        do {
            let detalle = try await apiService.obtenerDetallePerfil(id: perfil.id)
            
            self.post = try await cargarPostsParaPerfil(perfil)
            
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
}


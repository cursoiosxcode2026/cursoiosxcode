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
    
    //Obtiene los usuarios de la API https://dummyjson.com/users
    func cargarPerfiles() async {
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
    
    //Cerramos sesión, borrando el usuario actual
    func cerrarSesion() {
        usuarioActual = nil
    }
}

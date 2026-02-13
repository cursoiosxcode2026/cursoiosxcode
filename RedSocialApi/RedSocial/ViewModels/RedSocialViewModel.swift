//
//  VistaRickAndMortyViewModel.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 13/2/26.
//

/*import SwiftUI
import Observation

@Observable
class RedSocialViewModel {
    var perfiles: [Perfil] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let apiService : ApiService
    
    //pasamos apiServicee como parámetro para poder testearlo
    //o usarlo mientras desarrollamos
    //Por defecto le pasamos una instancia de ApiService
    init(apiService: ApiService = ApiService.instancia) {
        self.apiService = apiService
    }
    
    func cargarDatos() async {
        isLoading = true
        errorMessage = nil

        do {
            perfiles = try await apiService.obtenerPerfiles()
        } catch {
            errorMessage = "No se pudieron cargar los perfiles"
        }
        isLoading = false
    }
    
}
*/

import SwiftUI
import Observation

@Observable
class RedSocialViewModel {
    var perfiles: [Perfil] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiService.instancia) {
        self.apiService = apiService
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
        }
        await MainActor.run { isLoading = false }
    }
}


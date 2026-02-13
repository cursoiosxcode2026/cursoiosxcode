//
//  VistaRickAndMortyViewModel.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 13/2/26.
//

import SwiftUI
import Observation

@Observable
class RickAndMortyViewModel {
    var personajes: [Personaje] = []
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
            personajes = try await apiService.obtenerPersonajes()
        } catch {
            errorMessage = "No se pudieron cargar los personajes"
        }
        isLoading = false
    }
    
}

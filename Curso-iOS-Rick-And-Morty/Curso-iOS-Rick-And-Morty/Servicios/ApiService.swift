//
//  ApiService.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
//

import Foundation

enum NetworkError: Error {
    case urlInvalida
    case errorServidor(statusCode: Int)
    case errorDatos(detalle: String, errorOriginal: Error?)
    
    var description: String {
        switch self {
        case .urlInvalida:
            return "La URL proporcionada no es válida"
        case .errorServidor(let statusCode):
            return "Error del servidor. Código de estado: \(statusCode)"
        case .errorDatos(let detalle, let errorOriginal):
            if let error = errorOriginal {
                return "\(detalle). Error original: \(error.localizedDescription)"
                
            }
            return detalle
        }
    }
    
}

class ApiService {
    
    func obtenerPersonajes() async throws -> [Personaje] {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else {
            throw NetworkError.urlInvalida
        }
        
        //Descargamos datos
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //Comprobar si servidor estaba activo
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.errorServidor(statusCode: 0 )
        }
        //Comprobar si el estado es OK (200)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor (statusCode: httpResponse.statusCode)
        }
        
        //Decodificación
        
        do {
            let respuesta = try JSONDecoder().decode(RespuestaAPI.self, from: data)
            return respuesta.results
        } catch {
            print("Error decodificando: \(error)")
            throw NetworkError.errorDatos(
                detalle: "No se ha podido interpretar la respuesta del servidor",
                errorOriginal: error)
        }
        
    }
    
    func obtenerDetallePersonaje(id: Int) async throws -> PersonajeDetalle {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else {
            throw NetworkError.urlInvalida
        }
        //Descargamos datos
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //Comprobar si servidor estaba activo
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.errorServidor(statusCode: 0 )
        }
        
        //Comprobar si el estado es OK (200)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor (statusCode: httpResponse.statusCode)
        }
        
        //Decodificación
        
        do {
            let respuesta = try JSONDecoder().decode(PersonajeDetalle.self, from: data)
            return respuesta
        } catch {
            print("Error decodificando: \(error)")
            throw NetworkError.errorDatos(
                detalle: "No se ha podido interpretar la respuesta del servidor",
                errorOriginal: error)
        }
    }
}



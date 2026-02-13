//
//  ApiService.swift
//  RedSocial
//
//  Created by Equipo 7 on 11/2/26.
//

/*import Foundation

enum NetworkError: Error {
    case urlInvalida
    case errorServidor(statusCode: Int)
    case errorDatos(detalle: String, errorOriginal: Error?)
    
}

class ApiService {
    
    //Convertimos la clase a Singleton
    static let instancia = ApiService()
    
    private init() {}
    
    func obtenerPerfiles() async throws -> [Perfil] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
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
    
    func obtenerDetallePersonaje(id: Int) async throws -> PerfilDetalle {
        
        guard let url = URL(string: "https://dummyjson.com/users/\(id)") else {
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
            let respuesta = try JSONDecoder().decode(PerfilDetalle.self, from: data)
            return respuesta
        } catch {
            print("Error decodificando: \(error)")
            throw NetworkError.errorDatos(
                detalle: "No se ha podido interpretar la respuesta del servidor",
                errorOriginal: error)
        }
    }
    
    func obtenerPosts(urls: [String]) async throws -> [Post] {
        
        guard !urls.isEmpty else { return [] }
        
        //1º. Extraer los IDs de las URLs
        //convertir "https.//.../episode/10" -> 10
        
        let ids = urls.compactMap { urlString -> String? in
            return urlString.split(separator: "/").last?.description
        }.joined(separator: ",") //Resultado: ids = "10,11,15"
        
        guard let url = URL(string: "https://dummyjson.com/posts/\(ids)") else {
            throw NetworkError.urlInvalida
        }
        
        let(data,response) = try await URLSession.shared.data(from: url)
        
        //Comprobar si servidor estaba activo
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.errorServidor(statusCode: 0 )
        }
        
        //Comprobar si el estado es OK (200)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor (statusCode: httpResponse.statusCode)
        }
        
        //3º. Decodificación
        
        if let variosPost = try? JSONDecoder().decode([Post].self, from: data) {
            return variosPost
        }
        
        //A veces un personaje aparece en un solo episodio y la API devuelve un objeto
        //no un array
        
        else if let unPost = try? JSONDecoder().decode(Post.self, from: data) {
            return [unPost]
        }
        
        throw NetworkError.errorDatos(
            detalle: "Formato no reconocido",
            errorOriginal: nil)
    }
    
    func obtenerPerfilesPorIds(ids: [Int]) async throws -> [Perfil] {
        guard !ids.isEmpty else { return [] }
        
        let idsString = ids.map { String($0) }.joined(separator: ",")
        
        guard let url = URL(string: "https://dummyjson.com/users/\(idsString)") else {
            throw NetworkError.urlInvalida
        }
        
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
        
        //3º. Decodificación
        
        if let variosPerfiles = try? JSONDecoder().decode([Perfil].self, from: data) {
            return variosPerfiles
        }
        
        //A veces un personaje aparece en un solo episodio y la API devuelve un objeto
        //no un array
        
        else if let unPerfil = try? JSONDecoder().decode(Perfil.self, from: data) {
            return [unPerfil]
        }
        
        throw NetworkError.errorDatos(
            detalle: "Formato no reconocido",
            errorOriginal: nil)
        
    }
}


*/


import Foundation

enum NetworkError: Error {
    case urlInvalida
    case errorServidor(statusCode: Int)
    case errorDatos(detalle: String, errorOriginal: Error?)
}

class ApiService {
    
    static let instancia = ApiService()
    private init() {}
    
    // Obtener todos los perfiles
    func obtenerPerfiles() async throws -> [Perfil] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw NetworkError.urlInvalida
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        let respuesta = try JSONDecoder().decode(RespuestaAPI.self, from: data)
        var perfiles = respuesta.users
        
        // Asignamos titulo desde company
        for i in 0..<perfiles.count {
            perfiles[i].titulo = perfiles[i].company?.title ?? "Sin título"
        }
        
        return perfiles
    }
    
    // Obtener detalle de un perfil
    func obtenerDetallePersonaje(id: Int) async throws -> PerfilDetalle {
        guard let url = URL(string: "https://dummyjson.com/users/\(id)") else {
            throw NetworkError.urlInvalida
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        let perfil = try JSONDecoder().decode(Perfil.self, from: data)
        let detalle = PerfilDetalle(
            id: perfil.id,
            username: perfil.username,
            password: perfil.password,
            titulo: perfil.titulo,
            image: perfil.image,
            email: "email@example.com",  // DummyJSON no tiene email completo
            phone: "+0000000",
            post: ["Primer Post", "Segundo Post", "Tercer Post"]
        )
        
        return detalle
    }
    
    // Obtener perfiles por IDs (simulado)
    func obtenerPerfilesPorIds(ids: [Int]) async throws -> [Perfil] {
        var resultados: [Perfil] = []
        for id in ids {
            let perfil = try await obtenerDetallePersonaje(id: id)
            resultados.append(
                Perfil(id: perfil.id,
                       username: perfil.username,
                       password: perfil.password,
                       titulo: perfil.titulo,
                       image: perfil.image,
                       company: nil)
            )
        }
        return resultados
    }
}


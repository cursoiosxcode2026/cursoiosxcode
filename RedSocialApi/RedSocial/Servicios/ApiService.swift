//
//  ApiService.swift
//  RedSocial
//
//  Created by Equipo 7 on 11/2/26.
//
import Foundation

enum NetworkError: Error {
    case urlInvalida
    case errorServidor(statusCode: Int)
    case errorDatos(detalle: String, errorOriginal: Error?)
}

class ApiService {
    
    static let instancia = ApiService()
    private init() {}
    
    func obtenerPerfiles() async throws -> [Perfil] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw NetworkError.urlInvalida
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.errorServidor(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        do {
            let respuesta = try JSONDecoder().decode(RespuestaAPI.self, from: data)
            var perfiles = respuesta.users
            
            // Asignamos titulo desde company
            for i in 0..<perfiles.count {
                perfiles[i].titulo = perfiles[i].company?.title ?? "Sin título"
            }
            
            return perfiles
        } catch {
            print("❌ ERROR DECODIFICANDO PERFILES:", error)
            throw error
        }
    }

    
    // Obtener detalle de un perfil
    func obtenerDetallePerfil(id: Int) async throws -> PerfilDetalle {
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
            password: perfil.password ?? "",
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
            let perfil = try await obtenerDetallePerfil(id: id)
            resultados.append(
                Perfil(id: perfil.id,
                       username: perfil.username,
                       password: perfil.password,
                       image: perfil.image,
                       company: nil,
                       titulo: perfil.titulo,)
            )
        }
        return resultados
    }
    

        func obtenerPostsAleatorios(cantidad: Int) async throws -> [Post] {
            guard let url = URL(string: "https://dummyjson.com/posts") else {
                throw NetworkError.urlInvalida
            }

            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.errorServidor(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }

            struct RespuestaPosts: Codable {
                let posts: [PostAPI]
            }

            struct PostAPI: Codable {
                let id: Int
                let title: String
                let body: String
                let reactions: Post.Reactions
                
            }

            let respuesta = try JSONDecoder().decode(RespuestaPosts.self, from: data)

            func fechaAleatoria() -> String {
                let diasAtras = Int.random(in: 0...30)
                let fecha = Calendar.current.date(byAdding: .day, value: -diasAtras, to: Date())!
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                return formatter.string(from: fecha)
            }

            let postsAleatorios = respuesta.posts.shuffled().prefix(cantidad).map { p in
                Post(
                    id: p.id,
                    name: p.title,
                    body: p.body,
                    reactions: p.reactions,
                    air_date: fechaAleatoria(),
                    image: "https://picsum.photos/200?random=\(p.id)"
                
                )
            }

            return postsAleatorios
        }

}


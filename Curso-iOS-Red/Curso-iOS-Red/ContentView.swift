//
//  ContentView.swift
//  Curso-iOS-Red
//
//  Created by Equipo 7 on 11/2/26.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    //Podemos omitir los campos que no necesitamos como userId
    
    
    
}

struct ContentView: View {
    
    @State private var posts: [Post] = []
    
    var body: some View {
    VStack {
      
      Button("Crear post") {
          Task {
              try await crearPost()
          }
      }
      
      .buttonStyle(.borderedProminent)
            List(posts) { post in
                HStack {
                    Text("\(post.id)")
                    Text(post.title)
                }
                
            }
        }
        .padding()
        .task {
            do {
               try await posts = obtenerPost()
            } catch {
                print(error)
            }
        }
    }
    
    func obtenerPost() async throws -> [Post] {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //Si en la API tenemos: nombre_usuario (Snake case)
        //Y en nuestro struct tenemos: nombreUsuario, .convertFromSnakeCase nos convierte a
        // camelCase
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw URLError(.badURL)
        }
        
        //Usamos un método GET de forma implícita
        //Con URLSession hacemos  las peticiones
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            let respuesta = response as? HTTPURLResponse
            print(respuesta?.statusCode)
            throw URLError(.badServerResponse)
        }
        
        let posts = try JSONDecoder().decode([Post].self, from: data)
        return posts
    }
    
    //Usaremos el verbo "POST" de HTTP para crear una publicacion (Post)
    func crearPost() async throws {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Indicamos que enviamos JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let nuevoPost = Post(id: 0, title: "Mi primera publicación", body:"Hola que tal")
        
        let datosAEnviar = try JSONEncoder().encode(nuevoPost)
        request.httpBody = datosAEnviar
        
        //Enviamos los datos
        let(data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
        
        print("\(httpResponse.statusCode)")
        print("Post creado correctamente")
    }
}

#Preview {
    ContentView()
}

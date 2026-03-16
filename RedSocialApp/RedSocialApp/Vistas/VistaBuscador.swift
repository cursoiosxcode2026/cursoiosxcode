//
//  VistaBuscador.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaBuscador: View {
    
    @State private var textoBuscado: String = ""
    @State private var posts: [Post] = []
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Introduce lo que buscas", text: $textoBuscado)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Recorremos los índices del array
                ForEach(posts.indices, id: \.self) { index in
                    let postBinding = $posts[index]   // binding mutable para la vista detalle
                    let post = posts[index]           // valor inmutable para filtrar y mostrar
                    
                    // Filtramos por texto
                    if textoBuscado.isEmpty || post.name.lowercased().contains(textoBuscado.lowercased()) {
                        HStack {
                            NavigationLink {
                                VistaDetallePost(post: postBinding) // pasamos binding
                            } label: {
                                AsyncImage(url: URL(string: post.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Rectangle())
                                
                                Text(post.name)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .searchable(text: $textoBuscado, prompt: "Buscar perfiles o posts")
            .navigationTitle("Buscador")
            .task {
                do {
                    posts = try await ApiService.instancia.obtenerPostsAleatorios(cantidad: 30)
                } catch {
                    print("Error cargando datos: \(error)")
                }
            }
            .padding()
        }
    }
}

#Preview {
    VistaBuscador()
}


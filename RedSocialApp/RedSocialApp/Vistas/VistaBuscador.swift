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
        NavigationStack {
            VStack(spacing: 0) {
                // Buscador siempre visible
                TextField("Buscar posts", text: $textoBuscado)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Divider()

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(posts.indices, id: \.self) { index in
                            let postBinding = $posts[index]
                            let post = posts[index]

                            if textoBuscado.isEmpty || post.name.lowercased().contains(textoBuscado.lowercased()) {
                                HStack {
                                    NavigationLink {
                                        VistaDetallePost(post: postBinding)
                                    } label: {
                                        AsyncImage(url: URL(string: post.image)) { image in
                                            image.resizable().scaledToFill()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 50, height: 50)
                                        .clipShape(Rectangle())

                                        Text(post.name)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .task {
                do {
                    posts = try await ApiService.instancia.obtenerPostsAleatorios(cantidad: 30)
                } catch {
                    print("Error cargando datos: \(error)")
                }
            }
        }
    }
}

#Preview {
    VistaBuscador()
}

//
//  VistaDetallePost.swift
//  RedSocial
//
//  Created by Equipo 7 on 17/2/26.
//

import SwiftUI

struct VistaDetallePost: View {
    let post: Post
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: post.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 200)
            
            Text("Nombre: \(post.name)")
                .font(.title2.bold())
            
            Text("Fecha: \(post.air_date)")
                .font(.headline)
            
            HStack {
                
                Text(Image(systemName: "heart"))
                Text("\(post.likes)")
                Text(Image(systemName: "heart.slash"))
                Text("\(post.dislikes)")
                
                
            }
            
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detalle Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let postDummy = Post(
        id: 1,
        name: "Post Aleatorio",
        body: "Este es un post de prueba.",
        reactions: Post.Reactions(likes: 10, dislikes: 2),
        air_date: "Hoy",
        image: "https://picsum.photos/200"
    )
        VistaDetallePost(post: postDummy)

}

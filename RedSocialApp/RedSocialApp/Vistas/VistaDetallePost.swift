//
//  VistaDetallePost.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import SwiftUI

struct VistaDetallePost: View {
    @Binding var post: Post
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("\(post.air_date)")
                .font(.headline)
            
            AsyncImage(url: URL(string: post.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 200)
            
            Text("\(post.name)")
                .font(.title2.bold())
            
            HStack {
                            Button {
                                post.userReaction = post.userReaction == .dislike ? .none : .dislike
                            } label: {
                                Image(systemName: "heart.slash.fill")
                                    .foregroundStyle(post.userReaction == .dislike ? .red : .gray)
                            }
                            Text("\(post.dislikes)")
                            
                            Spacer()
                            
                            Button {
                                post.userReaction = post.userReaction == .like ? .none : .like
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(post.userReaction == .like ? .green : .gray)
                            }
                            Text("\(post.likes)")
                        }
                        .font(.title3)
                        .padding(.top)
            Spacer()
        }
        .padding()
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

    VistaDetallePost(post: .constant(postDummy))
}


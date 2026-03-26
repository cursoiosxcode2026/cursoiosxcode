//
//  Post.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import Foundation

struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let body: String
    let reactions: Reactions
    let air_date: String
    var image: String = ""
    //Variable que se suma si el usuario hace click en like o dislike
    var userReaction: Reaction = .none
    
    struct Reactions: Codable, Hashable {
        let likes: Int
        let dislikes: Int
        
    }
    
    //Se suman los likes, dependiento si el usuario da like
    var likes: Int {
            reactions.likes + (userReaction == .like ? 1 : 0)
        }
    
    //Se suman los dislikes, dependiento si el usuario da dislike
    var dislikes: Int {
            reactions.dislikes + (userReaction == .dislike ? 1 : 0)
        }
    
    //Enum con los tipos de reacciones que puedes dar en un post
    enum Reaction: Codable{
        case like
        case dislike
        case none
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, body, reactions, air_date, image
    }
}

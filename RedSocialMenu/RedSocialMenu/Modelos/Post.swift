//
//  Post.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 12/3/26.
//

import Foundation


struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let body: String
    let reactions: Reactions
    let air_date: String
    var image: String = ""
    var userReaction: Reaction = .none
    
    struct Reactions: Codable, Hashable {
        let likes: Int
        let dislikes: Int
        
    }
    
  //  var likes: Int { reactions.likes }
  //  var dislikes: Int { reactions.dislikes }
    
    var likes: Int {
            reactions.likes + (userReaction == .like ? 1 : 0)
        }
    var dislikes: Int {
            reactions.dislikes + (userReaction == .dislike ? 1 : 0)
        }
    
    enum Reaction: Codable{
        case like
        case dislike
        case none
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, body, reactions, air_date, image
    }
}

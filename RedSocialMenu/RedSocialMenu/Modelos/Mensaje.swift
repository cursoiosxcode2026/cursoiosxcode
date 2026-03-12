//
//  Mensaje.swift
//  RedSocialMenu
//
//  Created by Equipo 7 on 12/3/26.
//

import Foundation
import FirebaseFirestore

struct Mensaje: Identifiable, Codable {
    // Firestore rellena DocumentID automáticamente
    @DocumentID var id: String?
    
    var texto: String
    var fecha: Date
    var idUsuario: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id, texto,fecha, idUsuario
    }
}

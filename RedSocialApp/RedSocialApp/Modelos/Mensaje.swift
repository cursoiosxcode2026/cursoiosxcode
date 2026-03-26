//
//  Mensaje.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import Foundation
import FirebaseFirestore

struct Mensaje: Identifiable, Codable {
    // Firestore rellena DocumentID automáticamente
    @DocumentID var id: String? = UUID().uuidString
    
    var texto: String
    var fecha: Date
    var idRemitente: Int
    var idReceptor: Int
    //Participantes seran, idRemitente e idReceptor
    var participantes : [Int]
    
    
    enum CodingKeys: String, CodingKey {
        case id, texto,fecha, idRemitente, idReceptor, participantes
    }
    
    // Inicializador personalizado para crear automáticamente participantes del mensaje
    init(texto: String, fecha: Date, idRemitente: Int, idReceptor: Int) {
        self.texto = texto
        self.fecha = fecha
        self.idRemitente = idRemitente
        self.idReceptor = idReceptor
        self.participantes = [idRemitente, idReceptor]
    }
}

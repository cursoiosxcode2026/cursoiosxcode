//
//  MensajeViewModel.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

import Foundation
import FirebaseFirestore

enum ConstantesFirestore {
    static let coleccionMensajes = "mensajes"
    
}


@Observable
class MensajeViewModel {
    var mensajes: [Mensaje] = []
   
    private var db = Firestore.firestore()
    var idUsuario: Int
    
    init(idUsuario: Int) {
        self.idUsuario = idUsuario
        cargarMensajes()
    }
    
    func cargarMensajes() {
        // Consulta a "mensajes" en Firestore, usando el idUsuario
        db.collection(ConstantesFirestore.coleccionMensajes)
            .whereField(Mensaje.CodingKeys.idUsuario.rawValue, isEqualTo: idUsuario)
            .order(by: Mensaje.CodingKeys.fecha.rawValue, descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error al leer los documentos: \(error?.localizedDescription ?? "Error desconocido")")
                    return
                }
                // Mapeo: del documento firestore al array de Gastos
                self.mensajes = documents.compactMap { doc -> Mensaje? in
                    try? doc.data(as: Mensaje.self)
                    
                }
            }
    }
    
    func anadirMensaje(texto: String,  idUsuario: Int, fecha: Date) {
        let nuevoMensaje = Mensaje(id: nil, texto: texto,
                               fecha: fecha,
                               idUsuario: idUsuario
                               
                            )
        do {
            _ = try db.collection(ConstantesFirestore.coleccionMensajes).addDocument(from: nuevoMensaje)
        } catch {
            print("Error guardando: \(error)")
        }
    }
    
    func borrarMensaje(indices: IndexSet) {
        indices.forEach { indice in
            let mensaje = mensajes[indice]
            
            guard let idMensaje = mensaje.id else {return}
            
            db.collection(ConstantesFirestore.coleccionMensajes).document(idMensaje).delete { error in
                if let error {
                    print("Error al borrar \(error.localizedDescription)")
                }
            }
        }
    }
    
    func actualizarMensajes(_ mensaje: Mensaje) {
        guard let idMensaje = mensaje.id else {return}
        do {
            try db.collection(ConstantesFirestore.coleccionMensajes)
            .document(idMensaje)
            .setData(from: mensaje, merge: true)
        } catch {
            print("Error al actualizar: \(error.localizedDescription)")
        }
    }
  
    
    //funcion heleper para casar la categoria que corresponde a un gasto
    func obtenerMensajes(id: String) -> Mensaje? {
        mensajes.first { $0.id == id }
    }
    

   
}


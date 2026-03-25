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
    var perfiles: [Perfil] = [] // perfiles traídos de tu API
   
    private var db = Firestore.firestore()
    var idRemitente: Int

    
    init(idRemitente: Int) {
        self.idRemitente = idRemitente
        cargarMensajes()
        cargarPerfiles()
    }
    func cargarMensajes() {
      //  listener?.remove()
        // Consulta a "mensajes" en Firestore, usando el idUsuario
        db.collection(ConstantesFirestore.coleccionMensajes)
            //.whereField(Mensaje.CodingKeys.idUsuario.rawValue, isEqualTo: idUsuario)
            .whereField("participantes", arrayContains: idRemitente)
            .order(by: Mensaje.CodingKeys.fecha.rawValue, descending: true)
            .addSnapshotListener { snapshot, error in
                print("🔥 Listener ejecutado")
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
    
    func anadirMensaje(texto: String, idRemitente: Int, idReceptor: Int, fecha: Date) {
        let nuevoMensaje = Mensaje(
                               texto: texto,
                               fecha: fecha,
                               idRemitente: idRemitente,
                               idReceptor: idReceptor,
                            )
        do {
            _ = try db.collection(ConstantesFirestore.coleccionMensajes).addDocument(from: nuevoMensaje)
         //   cargarMensajes()
        } catch {
            print("Error guardando: \(error)")
        }
    }
    
    
    func guardarMensaje(texto: String, idReceptor: Int, mensajeEditable: Mensaje?) {
        
        if let mensajeEditable {
            var actualizado = mensajeEditable
            actualizado.texto = texto
            actualizado.idReceptor = idReceptor
            
            actualizarMensajes(actualizado)
            
        } else {
            anadirMensaje(
                texto: texto,
                idRemitente: idRemitente,
                idReceptor: idReceptor,
                fecha: Date()
            )
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
  
    
    //funcion heleper para mostrar los mensajes que corresponde a un usuario
    func obtenerMensajes(id: String) -> Mensaje? {
        mensajes.first { $0.id == id }
    }
    
    func perfilUsuario(id: Int) -> Perfil? {
        return perfiles.first(where: { $0.id == id })
    }
    
    
    // Cargar perfiles desde API
    func cargarPerfiles() {
        // Evitamos recargar si ya hay datos
        guard perfiles.isEmpty else { return }
        
        Task {
            do {
                // Llamada correcta usando el singleton
                let perfilesAPI = try await ApiService.instancia.obtenerPerfiles()
                
                // Actualizamos en el hilo principal
                await MainActor.run {
                    self.perfiles = perfilesAPI
                }
                
            } catch {
                print("❌ Error cargando perfiles:", error)
            }
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
}


//
//  NuevoEstudianteViewModel.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 20/2/26.
//

import SwiftData
import SwiftUI
import Observation

@Observable
class NuevoEstudianteViewModel {
    var nombre = ""
    var email = ""
    var fechaNacimiento = Date()
    
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    
    //Validación
    
    var esValido: Bool {
        !nombre.isEmpty &&
        !email.isEmpty &&
        email.contains("@")
    }
    
    func guardar() {
        let estudiante = Estudiante(
            nombre: nombre,
            email: email,
            fechaNacimiento: fechaNacimiento)
        context.insert(estudiante)
    }
}

//
//  DetalleEstudiante.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//

import SwiftUI
import SwiftData

@Observable
class DetalleEstudianteViewModel {
    var estudiante: Estudiante
    var context: ModelContext
    var mostrarMatricular = false
    
    init(estudiante: Estudiante, context: ModelContext) {
        self.estudiante = estudiante
        self.context = context
    }
        
    func eliminarMatriculaEstudiante(matricula: Matricula) {
        context.delete(matricula)
    }
    
    func mostrarMatriculas () {
        mostrarMatricular = true
    }
    }

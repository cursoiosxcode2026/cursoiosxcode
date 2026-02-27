//
//  MatricularEstudianteViewModel.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 27/2/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable

class MatricularEstudianteViewModel {
    var estudiante: Estudiante
    var context: ModelContext
    var dismiss: DismissAction
    
    var cursos: [Curso]
    var cursosNoMatriculados: [Curso] {
        let cursosMatriculados = estudiante.cursos
        return cursos.filter { !cursosMatriculados.contains($0)}
    }
    
    var cursoSeleccionado: Curso?
    var semestre = "2026-1"
    var calificacion: Double?
    
    init(estudiante: Estudiante,
         cursos: [Curso],
         context: ModelContext,
         dismiss: DismissAction) {
        
        self.estudiante = estudiante
        self.cursos = cursos
        self.context = context
        self.dismiss = dismiss
    }
    
    func matricular() {
        guard let curso = cursoSeleccionado else {return}
        
        let matricula = Matricula(
            estudiante: estudiante,
            curso: curso,
            semestre: semestre,
            calificacion: calificacion)
        
        context.insert(matricula)
        dismiss()
    }
}

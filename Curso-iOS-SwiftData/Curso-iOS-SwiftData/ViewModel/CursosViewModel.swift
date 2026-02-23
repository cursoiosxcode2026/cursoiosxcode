//
//  CursosViewModel.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class CursosViewModel {
   var cursos :[Curso] = []
   var mostrarNuevoCurso = false
   var cursoSeleccionado: Curso?
   var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        cargarCursos()
    }
    
    func mostrarCurso() {
        mostrarNuevoCurso = true
    }
    
    func cargarCursos() {
        do {
            
            let descriptorCursos = FetchDescriptor<Curso>(
                sortBy: [SortDescriptor(\.nombre, order: .reverse)]
                )
            cursos = try context.fetch(descriptorCursos)
            
        } catch {
            print("Error cargando cursos: \(error)")
        }
        
    }
    
    
}

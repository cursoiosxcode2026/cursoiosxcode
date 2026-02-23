//
//  EstudianteViewModel.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//

import SwiftUI
import SwiftData


@Observable
class EstudianteViewModel {
    var estudiantes :[Estudiante] = []
    var mostrarNuevoEstudiante = false
    var context: ModelContext
    
    
    init(context: ModelContext) {
        self.context = context
        cargarEstudiantes()
    }
    
    
    func cargarEstudiantes() {
        do {
            
            let descriptorEstudiantes = FetchDescriptor<Estudiante>(
                sortBy: [SortDescriptor(\.nombre, order: .reverse)]
                )
            estudiantes = try context.fetch(descriptorEstudiantes)
            
        } catch {
            print("Error cargando estudiantes: \(error)")
        }
        
    }
    
    
    func eliminarEstudiante(estudiante: Estudiante) {
        context.delete(estudiante)
        cargarEstudiantes()
    }
    
    
}

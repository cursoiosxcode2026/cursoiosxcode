//
//  VistaMatricularEstudiante 2.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct VistaMatricularEstudiante: View {
    let estudiante: Estudiante
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var cursos: [Curso]
    var cursosNoMatriculados: [Curso] {
        let cursosMatriculados = estudiante.cursos
        return cursos.filter { !cursosMatriculados.contains($0)}
    }
    
    @State private var cursoSeleccionado: Curso?
    @State private var semestre = "2026-1"
    @State private var calificacion: Double?
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Curso",selection: $cursoSeleccionado) {
                    Text("Seleccionar curso")
                        .tag(nil as Curso?)
                    
                    ForEach(cursosNoMatriculados) { curso in
                        Text("\(curso.codigo) - \(curso.nombre)")
                            .tag(curso)
                    }
                }
                
                TextField("Semestre", text: $semestre)
                
                TextField("Calificación(opcional", value: $calificacion, format: .number)
                    .keyboardType(.decimalPad)
                
                Section {
                    Button("Matricular") {
                        guard let curso = cursoSeleccionado else {return}
                        
                        let matricula = Matricula(
                            estudiante: estudiante,
                            curso: curso,
                            semestre: semestre,
                            calificacion: calificacion)
                        
                        context.insert(matricula)
                        dismiss()
                        
                    }
                    .disabled(cursoSeleccionado == nil || semestre.isEmpty)
                }
                
            }
            .navigationTitle("Nueva matrícula")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
        
    }
}
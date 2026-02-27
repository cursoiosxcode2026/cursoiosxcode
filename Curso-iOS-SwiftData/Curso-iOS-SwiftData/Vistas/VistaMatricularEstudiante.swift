//
//  VistaMatricularEstudiante 2.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct VistaMatricularEstudiante: View {
    /*let estudiante: Estudiante
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
     */
    
    @State var viewModel: MatricularEstudianteViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Curso",selection: $viewModel.cursoSeleccionado) {
                    Text("Seleccionar curso")
                        .tag(nil as Curso?)
                    
                    ForEach(viewModel.cursosNoMatriculados) { curso in
                        Text("\(curso.codigo) - \(curso.nombre)")
                            .tag(curso)
                    }
                }
                
                TextField("Semestre", text: $viewModel.semestre)
                
                TextField("Calificación(opcional", value: $viewModel.calificacion, format: .number)
                    .keyboardType(.decimalPad)
                
                Section {
                    Button("Matricular") {
                        viewModel.matricular()
                        
                    }
                    .disabled(viewModel.cursoSeleccionado == nil || viewModel.semestre.isEmpty)
                }
                
            }
            .navigationTitle("Nueva matrícula")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { viewModel.dismiss() }
                }
            }
            
            .onAppear {
                        viewModel = MatricularEstudianteViewModel(
                            estudiante: viewModel.estudiante,
                            cursos: viewModel.cursos,
                            context: viewModel.context,
                            dismiss: viewModel.dismiss
                        )
                    }
        }
        
    }
}

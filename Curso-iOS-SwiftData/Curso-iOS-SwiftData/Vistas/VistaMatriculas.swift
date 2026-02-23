//
//  VistaMatriculas.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 20/2/26.
//


import SwiftUI
import SwiftData

struct  VistaMatriculas: View {
    
    @Environment(\.modelContext) private var context
    @State private var viewModel: MatriculasViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: MatriculasViewModel(context: context))
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Todas las matriculas") {
                    
                    ForEach(viewModel.todasLasMatriculas) { matricula in
                        VStack(alignment: .leading) {
                            Text("\(matricula.estudiante?.nombre ?? "N/A") - \(matricula.curso?.nombre ?? "N/A")")
                                 
                                 Text("Semestre: \(matricula.semestre)")
                        }
                    }
                    .onDelete { indices in
                        indices.forEach { indice in
                            let matricula = viewModel.todasLasMatriculas[indice]
                            viewModel.eliminarMatricula(matricula: matricula)
                        }
                        
                        
                    }
                }
                Section("Matriculas aprobadas") {
                    ForEach(viewModel.matriculasAprobadas) { matricula in
                        Text("\(matricula.estudiante?.nombre ?? "N/A"): \(matricula.calificacion ?? 0.0, specifier: "%.2f")")
                    }
                }
                
                Section("Matriculas de un alumno concreto") {
                    ForEach(viewModel.matriculasDeAlumno) { matricula in
                        Text("\(matricula.estudiante?.nombre ?? "N/A"): \(matricula.calificacion ?? 0.0, specifier: "%.2f")")
                    }
                }
            }
            
            .navigationTitle("Matriculas")
            
            .onAppear {
                viewModel.cargarMatriculas(nombreAlumno: "Carlos")
            }
        }
        
    }
}

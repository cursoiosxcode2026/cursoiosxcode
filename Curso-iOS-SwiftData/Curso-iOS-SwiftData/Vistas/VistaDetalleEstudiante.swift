//
//  VistaDetalleEstudiante.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct VistaDetalleEstudiante : View {
   /* let estudiante: Estudiante
    @Environment(\.modelContext) private var context
    @State private var mostrarMatricular = false */
    var viewModel: DetalleEstudianteViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading,spacing: 10) {
                Text(viewModel.estudiante.nombre)
                    .font(.title)
                
                Text(viewModel.estudiante.email)
                    .foregroundStyle(.secondary)
                Text("Nacimiento: \(viewModel.estudiante.fechaNacimiento, style: .date)")
                    .font(.caption)
            }
            
            .padding()
            
            List {
                Section("Cursos matriculados") {
                    if let matriculas = viewModel.estudiante.matriculas,
                        !matriculas.isEmpty {
                        ForEach(matriculas) { matricula in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(matricula.curso?.nombre ?? "Sin curso")
                                        .font(.headline)
                                    Text("Semestre: \(matricula.semestre)")
                                        .font(.caption)
                                    if let calificacion = matricula.calificacion {
                                        Text("Calificacion: \(calificacion, specifier: "%2f")")
                                            .font(.caption)
                                            .foregroundStyle(calificacion >= 5.0 ? .green : .red)
                                    }
                                }
                                
                                Spacer()
                                Button("Eliminar") {
                                    //context.delete(matricula)
                                }
                                .buttonStyle(.bordered)
                                .tint(.red)
                            }
                        }
                        
                    } else {
                        Text("No tiene cursos matriculados")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
           
        }
        
        .navigationTitle("Detalle Estudiante")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Matricular en curso") {
                    viewModel.mostrarMatriculas()
                }
            }
        }
       /* .sheet(isPresented: $viewModel.mostrarMatricular) {
            VistaMatricularEstudiante(estudiante: viewModel.estudiante)
    
        }
        */
    }
}

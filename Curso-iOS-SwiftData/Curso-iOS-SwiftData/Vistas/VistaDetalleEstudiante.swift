//
//  VistaDetalleEstudiante.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct VistaDetalleEstudiante : View {
    @State var viewModel: DetalleEstudianteViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Query private var cursos: [Curso]
    var cursosNoMatriculados: [Curso] {
        let cursosMatriculados = viewModel.estudiante.cursos
        return cursos.filter { !cursosMatriculados.contains($0)}
    }
    
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
                                    viewModel.eliminarMatriculaEstudiante(matricula: matricula)
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
   /*   .sheet(isPresented: $viewModel.mostrarMatricular) {
           VistaMatricularEstudiante(estudiante: viewModel.estudiante )
        }*/
        
        .sheet(isPresented: $viewModel.mostrarMatricular) {
            VistaMatricularEstudiante(
                viewModel: MatricularEstudianteViewModel(
                    estudiante: viewModel.estudiante,
                    cursos: cursosNoMatriculados, // o el array de cursos que quieras mostrar
                    context: viewModel.context,
                    dismiss: dismiss
                )
            )
        }
        
    }
}

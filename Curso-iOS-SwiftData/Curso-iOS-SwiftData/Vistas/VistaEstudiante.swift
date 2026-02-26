//
//  VistaEstudiante.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct VistaEstudiante: View {
    
    @State private var viewModel: EstudianteViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: EstudianteViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.estudiantes) { estudiante in
                    VStack(alignment: .leading) {
                        //TODO
                        NavigationLink(
                            destination: VistaDetalleEstudiante(
                                viewModel: DetalleEstudianteViewModel(
                                    estudiante: estudiante,
                                    context: viewModel.context
                                )
                            )
                        )  {
                                VStack (alignment: .leading) {
                                    Text(estudiante.nombre)
                                        .font(.headline)
                                    
                                    Text(estudiante.email)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("Cursos: \(estudiante.cursos.count)")
                                    
                                }
                            }
                    }
                }
                
                .onDelete { indices in
                    indices.forEach { indice in
                        let estudiante = viewModel.estudiantes[indice]
                        viewModel.eliminarEstudiante(estudiante: estudiante)
                    }
                    
                    
                }
                
            }
            .navigationTitle("Estudiantes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Agregar") {
                        viewModel.mostrarNuevoEstudiante.toggle()
                    }
                }
            }
            
            .sheet(isPresented: $viewModel.mostrarNuevoEstudiante, onDismiss: {
                viewModel.cargarEstudiantes()
            }, content: {
                VistaNuevoEstudiante(context: viewModel.context)
            })
            
            .onAppear {
                viewModel.cargarEstudiantes()
            }
        }
    }
}

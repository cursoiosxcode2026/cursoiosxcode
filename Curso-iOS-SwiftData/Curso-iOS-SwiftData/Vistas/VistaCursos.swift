//
//  VistaCursos.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct  VistaCursos: View {
  /*  @Environment(\.modelContext) private var context

     @State private var mostrarNuevoCurso = false
     @State private var cursoSeleccionado: Curso?
    @Query private var cursos :[Curso] */
    
    @State private var viewModel: CursosViewModel
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: CursosViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                ForEach(viewModel.cursos) { curso in
                    VStack(alignment: .leading) {
                        Text(curso.nombre)
                            .font(.headline)
                        
                        Text("Código: \(curso.codigo)")
                            .font(.caption)
                        Text("Profesor: \(curso.profesor)")
                            .font(.caption)
                        Text("Estudiantes: \(curso.estudiantes.count)")
                            .font(.caption)
                    }
                    .onTapGesture {
                        viewModel.cursoSeleccionado = curso
                    }
                }
            }
            .navigationTitle("Cursos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Agregar") {
                        viewModel.mostrarCurso()
                    }
                }
            }
            
            .sheet(isPresented: $viewModel.mostrarNuevoCurso, onDismiss: {
                viewModel.cargarCursos()
            }, content: {
                VistaFormularioCurso(context: viewModel.context)
            })
                   
                
        /*        .sheet(isPresented: $viewModel.mostrarNuevoCurso) {
                    VistaFormularioCurso(context: viewModel.context)
                }*/
                
            
            .sheet(item: $viewModel.cursoSeleccionado, onDismiss: {
                viewModel.cargarCursos()
            }, content: { curso in
                VistaFormularioCurso(context: viewModel.context, curso: curso)
            })
               
            /*.sheet(item: $viewModel.cursoSeleccionado) { curso in
                    VistaFormularioCurso(context: viewModel.context, curso: curso)
                }*/
            
            
                .onAppear {
                    viewModel.cargarCursos()
                }
                
            }
        }
    }

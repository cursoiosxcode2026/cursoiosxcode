//
//  ContentView.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 17/2/26.
//

import SwiftUI
import SwiftData

@Model
//Vamos a usar class porque SwiftData nos lo exige
class Tarea {
    var titulo: String
    var completada: Bool
    
    //SwiftData nos exigirá un init(...)
    init(titulo: String, completada: Bool = false) {
        self.titulo = titulo
        self.completada = completada
        
    }
    
}

struct VistaTareas: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Tarea.titulo)
    private var tareas: [Tarea]
    
    @State private var nuevaTarea = ""
    @State private var ocultarCompletadas = false
    
    private var tareasFiltradas: [Tarea] {
        if ocultarCompletadas {
            return tareas.filter {!$0.completada }
        } else {
            return tareas
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Nueva tarea", text: $nuevaTarea)
                    Button("Agregar") {
                        let tarea = Tarea(titulo: nuevaTarea)
                        context.insert(tarea)
                        nuevaTarea = ""
                    }
                    .disabled(nuevaTarea.isEmpty)
                }
                .padding()
                //Lista de Tareas
                
                List {
                    ForEach(tareasFiltradas) { tarea in
                        HStack {
                            Text(tarea.titulo)
                                .strikethrough(tarea.completada)
                            Spacer()
                            
                            if tarea.completada {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .onTapGesture {
                            tarea.completada.toggle()
                        }
                        
                    }
                    .onDelete { indices in
                        for indice in indices {
                            context.delete(tareas[indice])
                        }
                    
                    }
                }
            }
            .navigationTitle("Mis Tareas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        ocultarCompletadas.toggle()
                    } label: {
                        Image(systemName: ocultarCompletadas ? "eye.slash" : "eye")
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tarea.self,configurations: config)
    
    let tarea = Tarea(titulo: "Comprar leche")
    container.mainContext.insert(tarea)
    
   return VistaTareas()
        .modelContainer(container)
}

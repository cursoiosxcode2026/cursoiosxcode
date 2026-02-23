//
//  ContentView.swift
//  Curso-iOS-SwiftData
//
//  Created by Equipo 7 on 23/2/26.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        
        TabView {
            
            VistaEstudiante(context:context)
                .tabItem {
                    Label("Estudiantes", systemImage: "person.3")
                }
            
            VistaCursos(context: context)
                .tabItem {
                    Label("Cursos", systemImage: "book")
                }
            
            VistaMatriculas(context: context)
                .tabItem {
                    Label("Matrículas", systemImage: "list.bullet.clipboard")
                }
        }
    }
}

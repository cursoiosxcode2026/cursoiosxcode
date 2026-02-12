//
//  ContentView.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
//

import SwiftUI

struct VistaRickAndMorty: View {
    @State private var personajes: [Personaje] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    private let apiService = ApiService()
    @State private var path = NavigationPath()

    var body: some View {

        NavigationStack (path: $path){
            VStack {

                if isLoading {
                    ProgressView("Carga interdimensional...")
                        .controlSize(.large)
                    //si errorMessage no es nil, ejecutará
                    //este codigo:
                } else if let errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )

                    Button("Reintentar") {
                        Task { await cargarDatos() }
                    }

                } else {
                    List(personajes) { personaje in
                        
                        NavigationLink(value: personaje) {
                            HStack {
                                
                                //carga de la imagen
                                
                                AsyncImage(url: URL(string: personaje.image)) {
                                    imagen in
                                    imagen.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(personaje.name)
                                        .font(.headline)
                                    Text(personaje.species)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(
                                        personaje.status == "Alive" ? .green : .red
                                    )
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("La API de Rick & Morty")
            .navigationDestination(for: Personaje.self, destination: { personaje in
                VistaDetallePersonaje(personaje: personaje, path: $path)
                
                
            })
            .task {
                await cargarDatos()
            }
        }

    }

    func cargarDatos() async {
        isLoading = true
        errorMessage = nil

        do {
            personajes = try await apiService.obtenerPersonajes()
        } catch {
            errorMessage = "No se pudieron cargar los personajes"
        }
        isLoading = false
    }
}

#Preview {
    VistaRickAndMorty()
}

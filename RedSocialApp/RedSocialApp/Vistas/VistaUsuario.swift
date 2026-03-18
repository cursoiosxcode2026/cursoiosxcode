//
//  VistaUsuario.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 18/3/26.
//

import Foundation
import SwiftUI

struct VistaUsuario: View {
    @State private var viewModel = UsuarioViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path){
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                        .controlSize(.large)
                } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                    Button("Reintentar") {
                        Task { await viewModel.cargarDatos() }
                    }
                } else {
                   List(viewModel.perfiles) { perfil in
                      // NavigationLink(value: perfil) {
                       NavigationLink(destination: VistaDetallePerfil(perfil: perfil/*, path: $path/*, rsViewModel: viewModel*/ */)) {
                            HStack {
                                AsyncImage(url: URL(string: perfil.image)) { img in
                                    img.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(perfil.username)
                                        .font(.headline)
                                  //  Text(perfil.titulo ?? "Sin título")
                                    Text(perfil.company?.title ?? "Sin título")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Red Social")
            .navigationDestination(for: Perfil.self) { perfil in
                VistaDetallePerfil(
                    perfil: perfil /*,
                    path: $path/*,
                    rsViewModel: viewModel */ */
                )
            }
            .task {
                await viewModel.cargarDatos()
            }
        }
    }
}

#Preview {
   
        VistaUsuario()

}

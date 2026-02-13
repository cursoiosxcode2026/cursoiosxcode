//
//  VistaDetallePersonaje.swift
//  Curso-iOS-Rick-And-Morty
//
//  Created by Equipo 7 on 11/2/26.
//

/*import SwiftUI

struct VistaDetallePerfilView: View {
    
    @Binding var path: NavigationPath
    @State private var viewModel: DetallePerfilViewModel
    
    init(perfil: Perfil, path: Binding<NavigationPath>) {
        self._path = path
        self._viewModel = State(initialValue: DetallePerfilViewModel(perfil: perfil))
        
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing:20) {
                AsyncImage(url: URL(string: viewModel.perfil.image)) { img in
                    img.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .overlay(alignment: .bottom) {
                    Text(viewModel.perfil.username)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .padding()

                }
                
                if viewModel.isLoading {
                    ProgressView("Descargando datos...")
                        .frame(maxWidth: .infinity)
                } else if let detalle = viewModel.detalle {
                    VStack(alignment: .leading,spacing: 10) {
                        Text("Expediente #\(detalle.id)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                     Divider()
                        
                        
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    //Lista de episodios
                    
                    VStack(alignment: .leading) {
                        Text("Apariciones: \(viewModel.post.count)")
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        ForEach(viewModel.post) { post in
                            HStack {
                                Text(post.name)
                                    .font(.caption)
                                    .padding(5)
                                    .background(.blue.opacity(0.2))
                                    .cornerRadius(5)
                                
                                Text(post.name)
                                    .font(.body)
                                
                                Spacer()
                                Text(post.air_date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                            .padding(.vertical,4)
                            .padding(.horizontal)
                            
                            Divider().padding(.horizontal)
                        }
                        
                    }
                    //Lista de personajes relacionados
                    
                    if !viewModel.perfilesRelacionados.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Perfiles relacionados")
                                .font(.title2.bold())
                                .padding(.horizontal)
                                .padding(.top)
                            
                            ScrollView(.horizontal,showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.perfilesRelacionados) { perfil in
                                        NavigationLink(value: perfil) {
                                            VStack {
                                                AsyncImage(url: URL(string: perfil.image)) { img in
                                                    img.resizable().scaledToFill()
                                                } placeholder: {
                                                    Color.gray.opacity(0.3)
                                                }
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                                .shadow(radius: 3)
                                                
                                                Text(perfil.username)
                                                    .font(.caption)
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 80)
                                                    .foregroundStyle(.primary)
                                        }
                                            
                                       }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom,20)
                                
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //Resetea el Navigation path y vuelve a la vista principal
                    path = NavigationPath()
                } label: {
                    Image(systemName: "house.fill")
                }
            }
        }
        
        .task {
            await viewModel.cargarDatosCompletos()
        }
    }
}

struct GridInfo: View {
    let titulo: String
    let valor: String
    let icono: String
    
    var body: some View {
        HStack {
            Label(titulo,systemImage: icono)
                .foregroundStyle(.blue)
                .frame(width: 120,alignment: .leading)
           Text(valor)
                .bold()
            
        }
    }
}

#Preview {

    struct ContenedorPrevisualizacion: View {
        let perfil = Perfil(id: 1,
                           username: "emilys" ,
                           password:"emilyspass" ,
                           titulo: "admin",
                           image: "https://dummyjson.com/icon/emilys/128" )
        
        @State private var path = NavigationPath()
        
        var body: some View {
            NavigationStack(path: $path) {
                VistaDetallePerfil(perfil: perfil, path: $path)
                
                    .navigationDestination(for: Perfil.self) { perfil in
                        VistaDetallePerfil(perfil: perfil, path: $path)
                    }
            }
        }
    }
    return ContenedorPrevisualizacion()
  
}
*/
import SwiftUI

struct VistaDetallePerfil: View {
    
    @Binding var path: NavigationPath
    @State private var viewModel: DetallePerfilViewModel
    
    init(perfil: Perfil, path: Binding<NavigationPath>) {
        self._path = path
        self._viewModel = State(initialValue: DetallePerfilViewModel(perfil: perfil))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: viewModel.perfil.image)) { img in
                    img.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 300)
                
                Text(viewModel.detalle?.titulo ?? viewModel.perfil.titulo)
                    .font(.largeTitle.bold())
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView("Cargando detalles...")
                } else {
                    VStack(alignment: .leading) {
                        Text("Posts: \(viewModel.post.count)")
                            .font(.headline)
                        ForEach(viewModel.post) { post in
                            HStack {
                                Text(post.name)
                                Spacer()
                                Text(post.air_date).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    if !viewModel.perfilesRelacionados.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Perfiles relacionados")
                                .font(.title2.bold())
                                .padding(.vertical)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.perfilesRelacionados) { perfil in
                                        NavigationLink(value: perfil) {
                                            VStack {
                                                AsyncImage(url: URL(string: perfil.image)) { img in
                                                    img.resizable().scaledToFill()
                                                } placeholder: {
                                                    Color.gray.opacity(0.3)
                                                }
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                                Text(perfil.username)
                                                    .font(.caption)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    path = NavigationPath()
                } label: {
                    Image(systemName: "house.fill")
                }
            }
        }
        .task {
            await viewModel.cargarDatosCompletos()
        }
    }
}


//
//  ContentView.swift
//  Curso-iOS-Repository
//
//  Created by Equipo 7 on 20/2/26.
//

import SwiftUI
import SwiftData


//Usamos este struct para leer datos de la API REST
struct UsuarioDTO: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}


@Model
class Usuario {
    
    /* Nos da un para de ventajes usar Attribute:
     -Evitamos duplicados si hacemos dos veces 'context.insert(nuevoUsuario)
     -Activa el upsert (update+insert): nos sirve el mismo comando para actualizar que para insertar
     -Y por supuesto garantiza la unicidad
     */
    @Attribute(.unique) var id: Int
    var nombre: String
    var nombreUsuario: String
    var email: String
    
    init(id: Int, nombre: String, nombreUsuario: String, email: String) {
        self.id = id
        self.nombre = nombre
        self.nombreUsuario = nombreUsuario
        self.email = email
    }
    
    convenience init(from dto: UsuarioDTO) {
        self.init(id: dto.id,nombre: dto.name, nombreUsuario: dto.username,email:dto.email)
    }
}

enum APIError: Error {
    case URLInvalida
    case peticionFallida(Error)
    case errorDecodificar(Error)
}

class ApiService {
    func obtenerUsuariosDeApi() async throws -> [UsuarioDTO] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw APIError.URLInvalida
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            let usuarios = try JSONDecoder().decode([UsuarioDTO].self, from: data)
            return usuarios
        } catch let error as DecodingError {
            throw APIError.errorDecodificar(error)
        } catch {
            throw APIError.peticionFallida(error)
        }
    }
    
}

class MockApiService: ApiService {
    
    //Sobrescribimos la funcion de la clase padre para implementar una funcionalidad que nos devuelve datos sin tener que llamar a la API REST
    override func obtenerUsuariosDeApi() async throws -> [UsuarioDTO] {
        return [
            UsuarioDTO(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz"),
            UsuarioDTO(id: 2, name: "Ervin Howell", username: "Antonette", email: "Shanna@melissa.tv")
        ]
    }
}

class UsuarioRepository {
    
    //Gracias a las propiedades de la herencia de clases, en apiService puedo inyectar
    //tanto ApiService como MockApiService (polimorfismo)
   private let apiService: ApiService
   private let context: ModelContext //El context de SwiftData
    
    init(apiService: ApiService, context: ModelContext) {
        self.apiService = apiService
        self.context = context
    }
    
    func obtenerUsuarios() async throws -> [Usuario] {
        // 1. Intentar obtener usuarios de la persistencia con SwiftData
        //Como las @Query no son accesibles fuera de las Views de SwiftUI, tenemos que
        // usar otra forma de acceso
        
        let descriptor = FetchDescriptor<Usuario>()
        let usuariosEnPersistencia = try context.fetch(descriptor)
        
        if !usuariosEnPersistencia.isEmpty {
            print("Hemos cargado los usuarios desde la persistencia")
            return usuariosEnPersistencia
        }
        
        //2. Si no hemos encontrado los usuarios en local, los pedimos a la API Rest
        
        print("Pedimos datos a la API REST")
        
        let usuariosDTO = try await apiService.obtenerUsuariosDeApi()
        
        //3. Convertir los DTOs a nuestro modelo de persistencia y guardarlos
        
        let nuevosUsuarios = usuariosDTO.map { Usuario(from: $0)}
        
        for usuario in nuevosUsuarios {
            context.insert(usuario)
        }
        
        
        //Forzar la persistencia (en las Views no hace falta porque lo hace
        //Automáticamente
        try context.save()
        
        return nuevosUsuarios
        
    }
}


@Observable
class UsuariosViewModel {
    private(set) var usuarios: [Usuario] = []
    private(set) var cargando = false
    private(set) var mensajeError: String?
    
    private let repository: UsuarioRepository
    
    init(repository: UsuarioRepository) {
        self.repository = repository
    }
    
    @MainActor
    func cargarUsuarios() async {
        cargando = true
        mensajeError = nil
        
        do {
            usuarios =  try await repository.obtenerUsuarios()
        } catch {
            mensajeError = error.localizedDescription
        }
        
        cargando = false
        
    }
}
struct VistaUsuarios: View {
    @State private var viewModel: UsuariosViewModel
    
    
    init(repository: UsuarioRepository) {
        _viewModel = State(initialValue: UsuariosViewModel(repository:repository))
        
    }
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.cargando {
                    ProgressView("Cargando usuarios...")
                } else if let error = viewModel.mensajeError {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundStyle(.red)
                        Button("Reintentar") {
                            Task {
                                await viewModel.cargarUsuarios()
                            }
                        }
                    }
                } else {
                    List(viewModel.usuarios, id: \.id) { usuario in
                        VStack(alignment: .leading) {
                            Text(usuario.nombre)
                                .font(.headline)
                            Text(usuario.email)
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("Usuarios")
            .task {
                await viewModel.cargarUsuarios()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Usuario.self, configurations: config)
    let context = container.mainContext
    
   // let  apiService = MockApiService()
    let apiService = ApiService()
    
    let repository = UsuarioRepository(apiService: apiService, context: context)

    return VistaUsuarios(repository: repository)
        .modelContainer(container)
}

//
//  VistaPrincipal.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI
import Observation

enum Destino: Hashable {
    case principal
    case buscador
    case mensaje
    case perfil
}


@Observable
class Router {
    var path = NavigationPath() //Crea una ruta vacia
    
    func navigate(to destination: Destino) {
        path.append(destination)
    }
    
    //Para volver atrás
    func popRoute() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath() //Crea una ruta vacia de nuevo
    }
}

struct VistaPrincipal: View {
    @Environment(RedSocial.self) private var redSocial
    @Environment(Router.self) private var router
    
    var body: some View {
        @Bindable var bindingRouter = router
        
        NavigationStack(path: $bindingRouter.path) {
            
            HStack(spacing: 10) {
               Button("Ir a vista principal") {
                   router.popToRoot()
                }
                
                Button("Ir a vista buscador") {
                    
                    router.navigate(to: .buscador)
                }
                
                Button("Ir a vista mensaje") {
                    router.navigate(to: .mensaje)
                }
                
                Button("Ir a vista perfil") {
                    router.navigate(to: .perfil)
                }
            }
            .navigationDestination(for: Destino.self) { destino in
                switch destino {
               case .principal:
                   Text("Prueba")
                case .buscador:
                VistaBuscador()
                case .mensaje:
                    VistaMensaje()
                case .perfil:
                    VistaPerfil()
                    
                }
            }
            
            .onAppear {
                print(router.path)
            }
        }
    }
}
#Preview {
    VistaPrincipal()
        .environment(Router())
                .environment(RedSocial())
        }


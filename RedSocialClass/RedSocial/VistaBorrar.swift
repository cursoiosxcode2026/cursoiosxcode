//
//  VistaPrincipal2.swift
//  RedSocial
//
//  Created by Equipo 7 on 9/2/26.
//

import SwiftUI

struct VistaPrincipal2: View {
    @Environment(Router.self) private var router
    
    let opciones: [(titulo: String, destino: Destino, descripcion: String)] = [
        ("Vista Principal", .principal, "Volver a inicio"),
        ("Buscador", .buscador, "Buscar contenidos"),
        ("Mensajes", .mensaje, "Tus chats"),
        ("Perfil", .perfil, "Ver perfil")
    ]
    
    let columnas = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        @Bindable var bindingRouter = router
        
        NavigationStack(path: $bindingRouter.path) {
            ScrollView {
                
                LazyVGrid(columns: columnas, spacing: 12) {
                    ForEach(opciones, id: \.destino) { opcion in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(opcion.titulo)
                                .font(.headline)
                            Text(opcion.descripcion)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .onTapGesture {
                            router.navigate(to: opcion.destino)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Inicio")
            .navigationDestination(for: Destino.self) { destino in
                switch destino {
                case .principal:
                    Text("Vista Principal2")
                case .buscador:
                    VistaBuscador()
                case .mensaje:
                    VistaMensaje()
                case .perfil:
                    VistaPerfil()
                }
            }
        }
    }
}
#Preview {
    VistaPrincipal2()
        .environment(Router())
                .environment(RedSocial())
        }

//
//  VistaLazyVStackStickyHeaders.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 9/2/26.
//

import SwiftUI

struct VistaLazyVStackStickyHeaders: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                Section(header: VistaCabecera(titulo: "Favoritos")) {
                    
                    ForEach(1...5, id: \.self) { index in
                        
                        VistaCard(texto: "Favorito \(index)", color: .yellow)
                    }
                }
                
                Section(header: VistaCabecera(titulo: "Todos los contactos")) {
                    
                    ForEach(6...50, id: \.self) { index in
                        VistaCard(texto: "Contacto \(index)", color: .green)
                            .onAppear { print("Aparece \(index)")}
                            .onDisappear { print("Ya no es visible \(index)")}
                    }
                }
            }
        }
    }
}

struct VistaCabecera: View {
    let titulo: String
    var body: some View {
        Text(titulo)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

struct VistaCard: View {
    let texto: String
    let color: Color
    var body: some View {
        Text(texto)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.3))
            .cornerRadius(10)
            .padding(.horizontal)
            .background(.regularMaterial.opacity(0.3))
    }
}

#Preview {
    VistaLazyVStackStickyHeaders()
}

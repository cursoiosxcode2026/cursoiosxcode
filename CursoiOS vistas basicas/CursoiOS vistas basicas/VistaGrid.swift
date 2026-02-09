//
//  VistaGrid.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 9/2/26.
//

import SwiftUI

struct VistaGrid: View {
    var body: some View {
        VStack {
             Text("Tablero de productos")
                .font(.title2)
                .padding()
            
            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                
                //Encabezados
                GridRow {
                    Text("Productos").bold()
                    Text("Precio").bold()
                    Text("Stock").bold()
                    
                }
                
                Divider()
                
                GridRow {
                    Text("iPhone 17 Pro")
                        .padding(5)
                        .background(.blue.opacity(0.1))
                    Text("999 €")
                    Text("✅ Disp.")
                }
                
                
                GridRow {
                    Text("Macbook Pro M4 Max")
                        .padding(5)
                        .background(.orange.opacity(0.1))
                    
                    Text("2400 €")
                    Text("❌ Agotado")
                        
                }
                
                GridRow {
                    Text("Oferta Especial")
                        .gridCellColumns(2)
                        .frame(maxWidth: .infinity)
                        .background(.green.opacity(0.3))
        
                    Text("Solo hoy")
                }
            }
            .padding()
            .border(.gray)
        }
    }
}

#Preview {
    VistaGrid()
}

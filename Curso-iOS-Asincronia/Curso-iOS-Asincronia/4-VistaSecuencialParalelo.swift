//
//  VistaSecuencialParalelo.swift
//  Curso-iOS-Asincronia
//
//  Created by Equipo 7 on 10/2/26.
//

import SwiftUI

struct VistaSecuencialParalelo: View {
    
    @State private var log = ""
    @State private var tiempoTotal = 0.0

    var body: some View {
       
        VStack(spacing: 10){
            Text(log)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 300)
                .background(.gray.opacity(0.1))
            
            
        HStack{
                
            Button("Desayuno secuencial") {
                Task { await prepararDesayunoSecuencial() }
            }
            .buttonStyle(.bordered)
            
            Button("Desayuno paralelo") {
                Task{ await prepararDesayunoParalelo() }
            }
            .buttonStyle(.borderedProminent)
            }
        }
        
    }
    
    func hacerCafe() async -> String {
        log += "Preparando café ☕️ \n"
        try? await Task.sleep(for: .seconds(2))
        return "Café listo"
    }
    
    func tostarPan() async -> String {
        log += "Preparando tostada 🍞 \n"
        try? await Task.sleep(for: .seconds(3))
        return "Tostada lista 🍞"
    }
    
    func prepararDesayunoSecuencial() async {
        log = "⏳ Iniciando modo secuencial...\n"
        let inicio = Date()
        
        let cafe = await hacerCafe()
        log += cafe + "\n"
        
        let pan = await tostarPan()
        log += pan + "\n"
        
        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "Terminado en \(total) segundos."
        
    }
    
    func prepararDesayunoParalelo() async {
        
        log = "🚀 Iniciando modo paralelo \n"
        
        let inicio = Date()
        
        async let tareaCafe = hacerCafe()
        async let tareaTostada = tostarPan()
        
        //Espera a que ambos terminen
        let(resultadoCafe,resultadoTostada) = await(tareaCafe,tareaTostada)
        
        log += resultadoCafe + "\n"
        log += resultadoTostada + "\n"
        
        let fin = Date()
        let total = fin.timeIntervalSince(inicio).formatted()
        log += "Terminado en \(total) segundos."
        
        
    }
}

#Preview {
    VistaSecuencialParalelo()
}

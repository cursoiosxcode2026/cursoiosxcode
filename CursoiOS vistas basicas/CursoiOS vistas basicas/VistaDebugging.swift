//
//  VistaDebugging.swift
//  CursoiOS vistas basicas
//
//  Created by Equipo 7 on 28/1/26.
//

import SwiftUI
//documentacion
//https://developer.apple.com/documentation/xcode/stepping-through-code-and-inspecting-variables-to-isolate-bugs

struct VistaDebugging: View {
    @State private var temperaturaCelsius = ""
    @State private var temperaturaFahrenheit = "--"
    
    var body: some View {
        
        //Para mostrar los cambios en las variables de estado.
        let _ = Self._printChanges()
        
        VStack (alignment: .leading, spacing: 1) {
            Text("Grados Celsius (ºC)")
                .font(.title3)
                .foregroundStyle(.blue)
            
            
            TextField("Ej: 25.5", text: $temperaturaCelsius)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .font(.headline)
                .onChange(of: temperaturaCelsius) { vieja, nuevaTemp in
                    convertirTemperatura()
                }
        }
        
        Image(systemName: "arrow.down.circle.fill")
            .font(.system(size: 40))
            .foregroundStyle(.orange)
        
        
        VStack(alignment: .leading,spacing: 10) {
        Text("Grados Fahrenheit (ºF)")
            .font(.title3)
            .foregroundStyle(.red)
            
            Text(temperaturaFahrenheit)
                .font(.system(size:20,weight: .bold,design: .rounded))
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(.vertical,15)
                .background(
                    RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray5))
                )
        }
    }
    
    
    private func convertirTemperatura() {
        guard !temperaturaCelsius.isEmpty else{
            print("La temperatura celsius no puede estar vacia")
            temperaturaFahrenheit = "--"
            return
            
        }
        
        if let valorCelsius = Double(temperaturaCelsius) {
            let valorFahrenheit = celsiusAFahrenheit(valorCelsius)
            temperaturaFahrenheit = String(format: "%.2f", valorFahrenheit) + " ºF"
        } else {
            temperaturaFahrenheit = "Error! No entiendo"
        }
        
    }
    
    private func celsiusAFahrenheit(_ celsius: Double) -> Double {
        
        return (celsius * 9/5) + 32
    }
}

#Preview {
    VistaDebugging()
}

//
//  VistaSonidos.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import AudioToolbox     // para sonidos de sistema
import AVFoundation     // para sonido/video desde archivos

struct VistaSonidos: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Sonido de sistema estándar (clic)") {
                // 1104 es el ID del sonido
                AudioServicesPlaySystemSound(1104)
            }
            
            Button("Reproducir sonido") {
                reproducirSonido(nombre: "soniquete")
            }
        }
        // Opcional (como saber el contenido del Bundle)
        // Para debuggear en caso de que no encuentre el archivo
        .onAppear {
            print("--- Contenido del Bundle ---")
            if let resourcePath = Bundle.main.resourcePath {
                do {
                    let files = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                    for file in files {
                        // Vamos a filtrar los archivos de sonido
                        if file.hasSuffix(".mp3") || file.hasSuffix(".wav") {
                            print("Encontrado: \(file)")
                        }
                    }
                } catch {
                    print("Error leyendo bundle: \(error)")
                }
            }
        }
    }
    
    func reproducirSonido(nombre: String) {
        guard let url = Bundle.main.url(forResource: nombre, withExtension: "mp3") else {
            print("No se ha encontrado el archivo")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    VistaSonidos()
}

//
//  VistaPhotoPicker.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import PhotosUI

struct VistaPhotoPicker: View {
    @State private var fotoSeleccionada: PhotosPickerItem?
    @State private var imagenSeleccionada: Image?
    
    var body: some View {
        VStack {
            if let imagenSeleccionada {
                imagenSeleccionada
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
            PhotosPicker("Seleccionar foto", selection: $fotoSeleccionada, matching: .images)
                .onChange(of: fotoSeleccionada) {
                    Task {
                        if let data = try? await fotoSeleccionada?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            imagenSeleccionada = Image(uiImage: uiImage)
                        }
                    }
                }
        }
    }
}

#Preview {
    VistaPhotoPicker()
}

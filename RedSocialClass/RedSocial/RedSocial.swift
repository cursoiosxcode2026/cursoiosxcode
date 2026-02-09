//
//  ContentView.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI
import Observation

@Observable
class RedSocial {
    var nombreUsuario : String = ""
    var tabSeleccionado = 0
    var perfil = Perfil( nombre: "Juan Pérez",
                         titulo: "Creador de contenido",
                         descripcion: "Amante de los viajes y la fotografía",
                         reels: "1300",
                         seguidores: "12k",
                         seguidos: "3k")
    var cargando = false
    
    var instanceId: ObjectIdentifier {
        ObjectIdentifier(self)
    }
    
    init() {
        
        perfil = Perfil(
            nombre: "Juan Pérez",
            titulo: "Creador de contenido",
            descripcion: "Amante de los viajes y la fotografía",
            reels: "1300",
            seguidores: "12k",
            seguidos: "3k"
            )
    
        print("Se ha creado una instancia de AppData: \(instanceId)")
        

    }
    
    deinit {
        print("Se ha destruido una instancia de AppData: \(instanceId)")
    }
    
    //Meter la funcion cargar
    func cargarDatos() async {
        print("Cargando datos...")
        cargando = true
        
        //simulamos una espera para cargar los datos desde internet
        // Esto si tiene error cierra la app y ya
        // try! await Task.sleep(nanoseconds: 2_000_000_000)
        // es lo mismo que la opción de abajo
        //  try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
        } catch is CancellationError {
            print("Se ha cancelado la carga de datos")
        }catch {
            print("Otro error: \(error.localizedDescription)")
        }
        
        await MainActor.run {
            
            
        }
    }
}

//
//  Curso_iOS_APIsApp.swift
//  Curso-iOS-APIs
//
//  Created by Equipo 2 on 24/2/26.
//

import SwiftUI
import TipKit

@main
struct Curso_iOS_APIsApp: App {
    init() {
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

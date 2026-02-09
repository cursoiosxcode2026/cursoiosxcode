//
//  RedSocialApp.swift
//  RedSocial
//
//  Created by Equipo 7 on 30/1/26.
//

import SwiftUI


@main
struct RedSocialApp: App {
    @State private var redSocial = RedSocial()
    @State private var router = Router()
    
    var body: some Scene {
        WindowGroup {
         VistaPrincipal2()
                .environment(router)
                .environment(redSocial)
                

        }
    }
}


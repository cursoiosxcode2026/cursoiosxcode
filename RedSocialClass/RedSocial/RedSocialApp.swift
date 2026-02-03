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
    var body: some Scene {
        WindowGroup {
         VistaPrincipal()
                .environment(redSocial)

        }
    }
}


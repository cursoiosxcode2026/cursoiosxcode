//
//  RedSocialAppApp.swift
//  RedSocialApp
//
//  Created by Equipo 7 on 16/3/26.
//

//IMPORTANTE
//Perfiles: https://dummyjson.com/users
//Post: https://dummyjson.com/posts

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

//Más APIs: https://free-apis.github.io/#/browse
@main
struct RedSocialApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            VistaHome()
        }
    }
}




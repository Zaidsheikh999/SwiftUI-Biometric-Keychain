//
//  SwiftUiBiometricApp.swift
//  SwiftUiBiometric
//
//  Created by Zaid Sheikh on 12/06/2023.
//

import SwiftUI

@main
struct SwiftUiBiometricApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}

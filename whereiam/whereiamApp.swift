//
//  whereiamApp.swift
//  whereiam
//
//  Created by Yurii Troniak on 06.06.2022.
//

import SwiftUI

@main
struct whereiamApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}

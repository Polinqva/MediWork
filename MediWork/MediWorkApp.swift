//
//  MediWorkApp.swift
//  MediWork
//
//  Created by Polina Smirnova on 23.05.2023.
//

import SwiftUI

@main
struct MediWorkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

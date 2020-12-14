//
//  ReporterApp.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 11/12/2563 BE.
//

import SwiftUI
import Firebase

@main
struct ReporterApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            TabBarView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  ReporterApp.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 11/12/2563 BE.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Authentication

@main
struct ReporterApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
        GoogleSignInManager.shared.configGoogleSignIn(GIDSignIn.self)
    }

    var body: some Scene {
        WindowGroup {
            SignInViewRepresentable()
//            TabBarView(viewModel: TabBarViewModel())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct SignInViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInViewRepresentable>) -> UIViewController {
        return AuthenticationScene.viewController(.signInView)()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<SignInViewRepresentable>) {
    }
}

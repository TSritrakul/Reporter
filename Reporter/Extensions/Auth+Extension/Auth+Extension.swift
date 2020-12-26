//
//  Auth+Extension.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import Foundation
import Authentication
import GoogleSignIn
import Firebase
import Combine
import Data

extension GIDSignIn: AuthenticationType {
    
    public static var isLogin: PassthroughSubject = PassthroughSubject<Bool, Never>()
    
    public static func config() {
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = GIDSignIn.sharedInstance()
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let saveProfileUseCase: SaveProfileUseCase = SaveProfileUseCaseImpl()
                let profile: ProfileModel = ProfileModel(userID: user?.uid)
                saveProfileUseCase.execute(profile: profile)
                GIDSignIn.isLogin.send(true)
            } else {
//                let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
//                coreDataProvider.clear(Profile.self)
                GIDSignIn.isLogin.send(false)
            }
        }
    }
    
    public static func signIn() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            GIDSignIn.sharedInstance()?.presentingViewController = topController
        }
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    public static func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            GIDSignIn.isLogin.send(false)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

extension GIDSignIn: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error)
            return
          }

          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
        
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

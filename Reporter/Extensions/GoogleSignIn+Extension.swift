//
//  GoogleSignIn+Extension.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 14/12/2563 BE.
//

import Foundation
import Authentication
import GoogleSignIn
import Firebase
import Combine
import Data

extension GIDSignIn: GoogleSignInType {
    
    public static var isLogin: PassthroughSubject = PassthroughSubject<Bool, Never>()
    
    public static func config() {
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = GIDSignIn.sharedInstance()
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
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            guard let self = self else { return }
            GIDSignIn.isLogin.send(true)
            print(authResult)
            
//            let coreDataProvider: CoreDataProvider<Profile> = CoreDataProvider<Profile>(coreDataName: .data)
//            let entity = Profile(context: coreDataProvider.context)
//            entity.userID = authResult?.user.uid
//            coreDataProvider.save(entity).sink { (error) in
//                print(error)
//            } receiveValue: { (profile) in
//                print(profile)
//            }
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

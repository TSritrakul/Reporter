//
//  MainView.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 18/12/2563 BE.
//

import SwiftUI
import Authentication

struct MainView: View {
    @ObservedObject public var viewModel: MainViewModel
    
    var body: some View {
        if self.viewModel.isLogin {
            TabBarView(viewModel: TabBarViewModel())
        } else {
            AuthenticationScene.view(.signInView)()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}

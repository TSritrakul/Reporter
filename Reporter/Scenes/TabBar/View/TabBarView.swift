//
//  TabBarView.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 11/12/2563 BE.
//

import SwiftUI
import Authentication
import Transaction

struct TabBarView: View {
    @ObservedObject public var viewModel: TabBarViewModel
    @State var selectedView: Int = 1
    
    var body: some View {
        TabView(selection: $selectedView,
                content:  {
                    Text("Summary")
                        .tabItem { Text("Summary") }
                        .tag(1)
                    TransactionView(viewModel: TransactionViewModel())
                        .tabItem { Text("Transaction") }
                        .tag(2)
                        .onAppear {
//                            AuthenticationManager.shared.signOut()
//                            self.viewModel.fetchData()
                        }
                })
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabBarViewModel())
    }
}

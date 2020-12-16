//
//  TabBarView.swift
//  Reporter
//
//  Created by Thatchaphon Sritrakul on 11/12/2563 BE.
//

import SwiftUI
import Authentication

struct TabBarView: View {
    @State var selectedView: Int = 1
    
    var body: some View {
        TabView(selection: $selectedView,
                content:  {
                    SignInView()
                        .tabItem { Text("Summary") }
                        .tag(1)
                    Text("Transaction")
                        .tabItem { Text("Transaction") }
                        .tag(2)
                })
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

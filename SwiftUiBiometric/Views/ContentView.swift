//
//  ContentView.swift
//  SwiftUiBiometric
//
//  Created by Zaid Sheikh on 12/06/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        NavigationView {
            ScrollView (.vertical){
                VStack {
                    Text("Logged in")
                        .font(.largeTitle)
                }
            }
            .padding()
            .navigationTitle("Biometric")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authentication.updateValidation(success: false)
                    }) {
                        Text("Logout")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

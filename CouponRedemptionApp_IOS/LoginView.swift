//
//  Login.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        TextField(
            "Username",
             text: $username
        )
            .padding(10)
            .frame(width: 250)
            .fixedSize()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
            )
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
        TextField(
            "Password",
             text: $password
        )
            .padding(10)
            .frame(width: 250)
            .fixedSize()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
            )
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
        Button(action: {}){
            Text("Sign In")
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

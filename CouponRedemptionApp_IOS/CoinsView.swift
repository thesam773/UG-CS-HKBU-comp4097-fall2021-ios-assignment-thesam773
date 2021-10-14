//
//  CoinsView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CoinsView: View {
    var body: some View {
        List {
            NavigationLink(destination: LoginView()){
                Text("Coins <= 300")
            }
            NavigationLink(destination: LoginView()){
                Text("300 < Coins < 600")
            }
            NavigationLink(destination: LoginView()){
                Text("Coins >= 600")
            }
        }
        
    }
}

struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsView()
    }
}

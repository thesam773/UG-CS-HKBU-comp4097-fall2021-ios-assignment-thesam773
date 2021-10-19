//
//  CoinsView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CoinsView: View {
    var body: some View {
        NavigationView{
            List {
                NavigationLink(destination: CoinSubView(greaterThan: 0, lessThan: 300)){
                    Text("Coins <= 300")
                }
                NavigationLink(destination: CoinSubView(greaterThan: 301, lessThan: 599)){
                    Text("300 < Coins < 600")
                }
                NavigationLink(destination: CoinSubView(greaterThan: 600, lessThan: 9999999)){
                    Text("Coins >= 600")
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsView()
    }
}

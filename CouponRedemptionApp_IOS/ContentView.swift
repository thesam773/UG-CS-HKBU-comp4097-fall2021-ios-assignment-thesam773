//
//  ContentView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    @StateObject var qpons = Qpon()
    
    var body: some View {
            TabView {
                CouponView().tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Coupon")
                }
                MallsView().tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Mall")
                }
                CoinsView().tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Coin")
                }
                UserView().tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("User")
                }
            }
            .environmentObject(prospects)
            .environmentObject(qpons)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

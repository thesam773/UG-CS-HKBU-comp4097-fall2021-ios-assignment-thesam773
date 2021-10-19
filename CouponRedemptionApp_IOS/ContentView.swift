//
//  ContentView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            CouponView().tabItem {
                Image(systemName: "info.circle.fill")
                Text("Coupon")
            }
            .tag(1)
            MallsView().tabItem {
                Image(systemName: "house.circle.fill")
                Text("Mall")
            }
            .tag(2)
            CoinsView().tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Coin")
            }
            .tag(3)
            UserView().tabItem {
                Image(systemName: "person.circle.fill")
                Text("User")
            }
            .tag(4)
//            ShowAllCouponView().tabItem {
//                Image(systemName: "person.circle.fill")
//                Text("ShowAllCouponView")
//            }
//            .tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

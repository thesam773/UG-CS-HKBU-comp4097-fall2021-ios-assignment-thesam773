//
//  ShowAllCouponView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 18/10/2021.
//

import SwiftUI

struct ShowAllCouponView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var user: FetchedResults<User>
    
    var body: some View {
        
        List(user) { ur in
            HStack {
                Text(ur.username ?? "123")
            }
        }
        .navigationTitle("All Coupon")
    }
}

struct ShowAllCouponView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllCouponView()
    }
}

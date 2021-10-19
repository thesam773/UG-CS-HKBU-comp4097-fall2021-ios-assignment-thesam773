//
//  CoinSubView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 19/10/2021.
//

import SwiftUI

struct CoinSubView: View {
    @FetchRequest(entity: CouponData.entity(), sortDescriptors: [])
    var couponData: FetchedResults<CouponData>
    
    var greaterThan = -1
    var lessThan = -1
    init(greaterThan: Int,lessThan: Int ){
        self.greaterThan = greaterThan
        self.lessThan = lessThan
        
        self._couponData = FetchRequest(
            entity: CouponData.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "coin >= \(greaterThan) AND coin <= \(lessThan)")
        )
    }
    
    var body: some View {
        List(couponData) { cd in
            NavigationLink(destination: CouponDetailView(coupon_id: Int(cd.id), coupon_image: cd.image ?? "123", coupon_restaurant: cd.restaurant ?? "123", coupon_title: cd.title ?? "123", coupon_coin: Int(cd.coin), coupon_mall: cd.mall ?? "123", coupon_expirydate: cd.expirydate ?? "123")){
                HStack {
                    Text(cd.restaurant ?? "123") + Text(cd.mall ?? "123")
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct CoinSubView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSubView(greaterThan: 0, lessThan: 99999)
    }
}

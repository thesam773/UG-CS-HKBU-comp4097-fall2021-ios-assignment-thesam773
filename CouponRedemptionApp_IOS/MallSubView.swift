//
//  MallSubView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 19/10/2021.
//

import SwiftUI

struct MallSubView: View {
    @FetchRequest(entity: CouponData.entity(), sortDescriptors: [])
    var couponData: FetchedResults<CouponData>
    
    var mall = ""
    init(mall: String){
        self.mall = mall
        
        self._couponData = FetchRequest(
            entity: CouponData.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "mall == %@", mall)
        )
    }
    
    var body: some View {
            List(couponData) { cd in
                NavigationLink(destination: CouponDetailView(coupon_id: Int(cd.id), coupon_image: cd.image ?? "123", coupon_restaurant: cd.restaurant ?? "123", coupon_title: cd.title ?? "123", coupon_coin: Int(cd.coin), coupon_mall: cd.mall ?? "123", coupon_expirydate: cd.expirydate ?? "123")){
                    HStack {
                        Text(cd.restaurant ?? "123")
                    }
                }
            }
    }
}

struct MallSubView_Previews: PreviewProvider {
    static var previews: some View {
        MallSubView(mall:"mall")
    }
}

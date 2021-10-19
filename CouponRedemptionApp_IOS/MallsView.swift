//
//  MallsView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct MallsView: View {
    
    @EnvironmentObject var prospects: Prospects
    @FetchRequest(entity: CouponMall.entity(), sortDescriptors: [])
    
    var couponMall: FetchedResults<CouponMall>
    
    var body: some View {
        NavigationView{
            List(couponMall) { ml in
                NavigationLink(destination: MallSubView(mall: ml.mall ?? "123")){
                    HStack {
                        Text(ml.mall ?? "123")
                    }
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
        .navigationTitle("Malls")
    }
}

struct MallsView_Previews: PreviewProvider {
    static var previews: some View {
        MallsView()
    }
}

//
//  MallsView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct MallsView: View {
    @EnvironmentObject var prospects: Prospects
    @EnvironmentObject var qpons: Qpon
    
    
    
//    init() {
//      self.qpon = qpon
//    }
    
    var body: some View {
        Text("People:\(qpons.qponsName)")
//        let _ = print("DLLLMMMMMMM\(qpon)")
    }
}

struct MallsView_Previews: PreviewProvider {
    static var previews: some View {
        MallsView().environmentObject(Qpon())
    }
}

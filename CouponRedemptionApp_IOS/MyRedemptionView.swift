//
//  MyRedemptionView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 19/10/2021.
//

import SwiftUI

struct MyRedemptionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var redem: [Coupons] = []
    
    //
    //    init(){
    //        self.redem = redemption(redeem:[], updatedAt: 0, id: 0, userID: "", username: "", role:"", coin: 0)
    //    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            //            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            List(redem) {
                couponsItem in
                NavigationLink(destination: CouponDetailView(coupon_id: couponsItem.id, coupon_image: couponsItem.image,coupon_restaurant: couponsItem.restaurant,coupon_title: couponsItem.mall,coupon_coin: couponsItem.coin,coupon_mall: couponsItem.mall,coupon_expirydate: couponsItem.expirydate)){
                    VStack{
                        Text("\(couponsItem.restaurant)\n    \(couponsItem.mall)")
                    }
                }
            }
            .navigationTitle("My Redeemed Coupon")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            .onAppear(perform: startLoad).refreshable {
                startLoad()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct MyRedemptionView_Previews: PreviewProvider {
    static var previews: some View {
        MyRedemptionView()
    }
}

//struct redeem: Identifiable {
//    let createdAt: Int
//    let updatedAt: Int
//    let id: Int
//    let title: String
//    let quota: Int
//    let coin: Int
//    let restaurant: String
//    let expirydate: String
//    let region: String
//    let mall: String
//    let image: String
//    let detail: String
//}
//
//extension redeem: Decodable {}

struct redemption: Identifiable {
    let Redeem: [Coupons]
    let updatedAt: Int
    let id: Int
    let userID: String
    let username: String
    let role: String
    let coin: Int
}

extension redemption: Decodable {}

extension MyRedemptionView{
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLoad() {
        print("Start Loadddddd")
        
        let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/user/MyRedeem")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...200).contains(httpResponse.statusCode) else {
                      self.handleServerError(response)
                      return
                  }
            if let data = data, let red = try? JSONDecoder().decode(redemption.self, from: data) {
                print("Load Data")
                self.redem = red.Redeem
            }
        }
        task.resume()
    }
}

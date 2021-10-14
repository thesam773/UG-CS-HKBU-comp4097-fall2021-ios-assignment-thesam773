//
//  CouponVIew.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CouponView: View {
    
    @State private var coupons: [Coupons] = []
    @State private var username = "fk"
    
    var body: some View {
        NavigationView{
            List(coupons) {
                couponsItem in
                NavigationLink(destination: CouponDetailView(coupon_id: couponsItem.id, coupon_image: couponsItem.image,coupon_restaurant: couponsItem.restaurant,coupon_title: couponsItem.mall,coupon_coin: couponsItem.coin,coupon_mall: couponsItem.mall,coupon_expirydate: couponsItem.expirydate)){
                    VStack{
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: couponsItem.image)){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .scaledToFit()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(couponsItem.title)
                        Text("Coins: "+String (couponsItem.coin))
                    }
                    .border(Color.black)
                    .padding()
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear(perform: startLoad)
    }
}

struct CouponView_Previews: PreviewProvider {
    static var previews: some View {
        CouponView()
    }
}

struct Coupons: Identifiable {
    let createdAt: Int
    let updatedAt: Int
    let id: Int
    let title: String
    let quota: Int
    let coin: Int
    let restaurant: String
    let expirydate: String
    let region: String
    let mall: String
    let image: String
    let detail: String
}

extension Coupons: Decodable {}

extension CouponView {
    
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func startLoad() {
        
        let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      self.handleServerError(response)
                      return
                  }
            
            //            if let data = data,
            //               let string = String(data: data, encoding: .utf8) {
            //                self.coupons = [Coupons(createdAt: 0, updatedAt: 0, id: 0, title: string,quota: 0,coin: 0,restaurant: "", expirydate: "",region: "", mall: "",image: "",detail: "")]
            //            }
            if let data = data, let coupons = try? JSONDecoder().decode([Coupons].self, from: data) {
                
                self.coupons = coupons
            }
        }
        task.resume()
    }
}

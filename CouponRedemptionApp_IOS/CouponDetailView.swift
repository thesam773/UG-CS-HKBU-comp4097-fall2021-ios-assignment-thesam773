//
//  CouponDetailView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CouponDetailView: View {
    var coupon_id = -1
    var coupon_image = ""
    var coupon_restaurant = ""
    var coupon_title = ""
    var coupon_coin = 0
    var coupon_mall = ""
    var coupon_expirydate = ""
    
    let coupons: [Coupons] = []
    
    init(coupon_id: Int, coupon_image: String, coupon_restaurant: String, coupon_title: String, coupon_coin: Int, coupon_mall: String, coupon_expirydate: String){
        self.coupon_id = coupon_id
        self.coupon_image = coupon_image
        self.coupon_title = coupon_title
        self.coupon_restaurant = coupon_restaurant
        self.coupon_mall = coupon_mall
        self.coupon_expirydate = coupon_expirydate
        self.coupon_coin = coupon_coin
    }
    
    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: coupon_image)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
            } else {
                // Fallback on earlier versions
            }
            VStack(){
                Text("\(coupon_restaurant)")
                    .bold()
                    .font(.system(size: 25))
                    .padding(.bottom,5)
                Text("\(coupon_title)")
                HStack{
                    Text("Mall: \(coupon_mall)")
                    Text("Coin: \(coupon_coin)")
                }
                Text("Expiry Date: \(coupon_expirydate)")
                HStack{
                    Button(action: {}){
                        Text("Redeem")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                    Button(action: {}){
                        Text("Address")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                }
            }
            .frame(
                maxWidth: .infinity
            )
            .font(.system(size: 20))
            .border(Color.black)
        }
        .frame(
           minWidth: 0,
           maxWidth: .infinity,
           minHeight: 0,
           maxHeight: .infinity,
           alignment: .topLeading
         )
        .padding()
    }
}

struct CouponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouponDetailView(coupon_id: 1, coupon_image:"https://media-cdn.tripadvisor.com/media/photo-s/19/e3/78/02/main-dining-area.jpg",coupon_restaurant:"restaurant name",coupon_title:"title",coupon_coin:0, coupon_mall:"mall", coupon_expirydate:"expy")
    }
}

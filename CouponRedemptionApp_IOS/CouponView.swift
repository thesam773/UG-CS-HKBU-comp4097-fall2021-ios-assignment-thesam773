//
//  CouponVIew.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CouponView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: CouponData.entity(), sortDescriptors: [])
    var couponData: FetchedResults<CouponData>
    @State private var coupons: [Coupons] = []
    @State private var username = "fk"
    
    var body: some View {
        NavigationView{
            if #available(iOS 15.0, *) {
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
                .onAppear(perform: startLoad).refreshable {
                    startLoad()
                }
            } else {
                // Fallback on earlier versions
            }
        }
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
        print("Start Loadddddd")
        
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
            
            if let data = data, let coupons = try? JSONDecoder().decode([Coupons].self, from: data) {
                print("Load Data")
                
                couponData.forEach{ qpon in
                    viewContext.delete(qpon)
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                
                self.coupons = coupons
                
                self.coupons.forEach{ qpon in
                    let couponData = CouponData(context: viewContext)
                    couponData.id = Int64(qpon.id)
                    couponData.createdAt = Int64(qpon.createdAt)
                    couponData.updatedAt = Int64(qpon.updatedAt)
                    couponData.quota = Int64(qpon.quota)
                    couponData.coin = Int64(qpon.coin)
                    couponData.detail = qpon.detail
                    couponData.expirydate = qpon.expirydate
                    couponData.image = qpon.image
                    couponData.mall = qpon.mall
                    couponData.region = qpon.region
                    couponData.restaurant = qpon.restaurant
                    couponData.title = qpon.title
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
        }
        task.resume()
    }
}

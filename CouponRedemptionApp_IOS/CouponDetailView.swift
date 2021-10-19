//
//  CouponDetailView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct CouponDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var user: FetchedResults<User>
    
    var coupon_id = -1
    var coupon_image = ""
    var coupon_restaurant = ""
    var coupon_title = ""
    var coupon_coin = 0
    var coupon_mall = ""
    var coupon_expirydate = ""
    @State var showAlert = false
    @State var showAlert2 = false
    @State var showAlert3 = false
    @State var alertMsg = ""
    //    @State private var redem: [Coupons] = []
    
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
                    //                    self.redeemCoupon(id: coupon_id)
                    if user.count>0 {
                        Button(action: {showAlert=true}){
                            Text("Redeem")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("To redeem this coupon?"),
                                primaryButton: .destructive(Text("Confirm")) {
                                    //                                print("Deleting...")
                                    self.redeemCoupon(id: coupon_id)
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }else{
                        Button(action: {showAlert3=true}){
                            Text("Redeem")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                        }
                        Text("")
                            .alert(isPresented: $showAlert3) {
                                Alert(
                                    title: Text("Please Login!"),
                                    dismissButton: .default(Text("Ok"))
                                )
                            }
                    }
                    Text("")
                        .alert(isPresented: $showAlert2) {
                            Alert(
                                title: Text("\(alertMsg)"),
                                dismissButton: .default(Text("Ok"))
                            )
                        }
                    NavigationLink(destination: MapView(coupon_mall: coupon_mall)){
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

extension CouponDetailView{
    func redeemCoupon(id: Int){
        let stringID = String(id)
        print(stringID)
        guard let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/user/QPon/add/\(stringID)") else {
            return
        }
        
        //        let data : Data = "username=\(user1)&password=\(pass)&grant_type=password".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        //        request.httpBody = data
        
        print("one called")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        // vs let session = URLSession.shared
        // make the request
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if let error = error
            {
                print(error)
            }
            else if let response = response {
                print("her in resposne")
                
            }else if let data = data
            {
                print("here in data")
                print(data)
            }
            
            let httpResponse = response as? HTTPURLResponse
            
            print(httpResponse?.statusCode)
            if httpResponse?.statusCode == 200{
                alertMsg = "Redeem Successfully"
                showAlert2 = true
                print("Redeem Successfully")
                return
            } else if httpResponse?.statusCode == 403{
                alertMsg = "Forbidden"
                showAlert2 = true
                print("Forbidden")
                return
            }else if httpResponse?.statusCode == 408{
                alertMsg = "You do not have enough coin "
                showAlert2 = true
                print("You do not have enough coin ")
                return
            }else if httpResponse?.statusCode == 409{
                alertMsg = "Already added."
                showAlert2 = true
                print("Already added.")
                return
            }else if httpResponse?.statusCode == 410{
                alertMsg = "This QPon sold out!"
                showAlert2 = true
                print("This QPon sold out!")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...200).contains(httpResponse.statusCode) else{
                      print("123123123")
                      return
                  }
            
            DispatchQueue.main.async { // Correct
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                let decoder = JSONDecoder()
                
                print(String(data: responseData, encoding: .utf8))
            }
        })
        task.resume()
    }
}

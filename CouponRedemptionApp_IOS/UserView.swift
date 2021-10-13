//
//  UserView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Image("User_Icon")
                        .resizable()
                        .frame(width: 192.0, height: 192.0)
                    Text("Peter Chan")
                    //                    .fontWeight(.bold)
                        .font(.title)
                }
                List {
                    NavigationLink(destination: LoginView()){
                        Text("Logout / Login")
                    }
                    Text("My Redeemed Coupons")
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

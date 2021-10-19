//
//  UserView.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var user: FetchedResults<User>
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    
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
                    if user.count>0 {
                        if #available(iOS 15.0, *) {
                            Text("Logout / Login")
                                .onTapGesture {
                                    self.userLogout()
                                    showingAlert=true// 2)
                                }
                                .alert("Logout Success", isPresented: $showingAlert) {
                                    Button("OK", role: .cancel) { }
                                }
                        } else {
                            // Fallback on earlier versions
                        }
                    }else{
                        NavigationLink(destination: LoginView()){
                            Text("Logout / Login")
                        }
                    }
                    if user.count>0 {
                        NavigationLink(destination: MyRedemptionView()){
                            Text("My Redeemed Coupons")
                        }
                    }else{
                            if #available(iOS 15.0, *) {
                                Text("My Redeemed Coupons")
                                    .onTapGesture {
                                        self.alertLogin()
                                    }
                                    .alert("Please Login", isPresented: $showingAlert2) {
                                        Button("OK", role: .cancel) { }
                                    }
                            } else {
                                // Fallback on earlier versions
                            }
                    }
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

extension UserView{
    
    func alertLogin(){
        showingAlert2 = true
    }
    func userLogout() {
        guard let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/user/MyRedeem") else {
            return
        }
//        let data : Data = "username=\(user1)&password=\(pass)&grant_type=password".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
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
            
            
            DispatchQueue.main.async { // Correct
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                print(String(data: responseData, encoding: .utf8))

                user.forEach{ ur in
                    viewContext.delete(ur)
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
        })
        task.resume()
    }
}

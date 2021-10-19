//
//  Login.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var user: FetchedResults<User>
    var userData: UserModel
    @State var isLogin = false
    @State var isLogout = true
    @State var showAlert = false
    @State private var username: String = ""
    @State private var password: String = ""
    var event1Callback: () -> Void = {}
    
    init(){
        self.userData = UserModel(createdAt: 0, updatedAt: 0, id: 0, userID: "", username: "", role: "", coin: 0)
    }
    var body: some View {
        //        if isLogin{
        //
        //        }else{
        TextField(
            "Username",
            text: $username
        )
            .padding(10)
            .frame(width: 250)
            .fixedSize()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
            )
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
        TextField(
            "Password",
            text: $password
        )
            .padding(10)
            .frame(width: 250)
            .fixedSize()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
            )
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
        Button(action: {userLogin(username: username, password: password)}){
            Text("Sign In")
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(10)
        }
        .alert(isPresented: $showAlert) {
            if self.isLogin {
                return  Alert(title: Text("Login Success"),dismissButton: .destructive(Text("OK")){
                    self.presentationMode.wrappedValue.dismiss()
                })
            } else {
                return  Alert(title: Text("Login Fail"), message: Text(""))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
struct UserModel: Identifiable {
    let createdAt: Int
    let updatedAt: Int
    let id: Int
    let userID: String
    let username: String
    let role: String
    let coin: Int
}


extension UserModel: Decodable {}

extension LoginView{
    
    func userLogin(username: String, password: String) {
        guard let url = URL(string: "https://comp4097-2021ass1.herokuapp.com/user/login") else {
            return
        }
        let user1 = username
        let pass = Int(password)!
        print(user1)
        print(pass)
        let data : Data = "username=\(user1)&password=\(pass)&grant_type=password".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data
        
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
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...200).contains(httpResponse.statusCode) else {
                      print("123123123")
                      isLogout = true
                      isLogin = false
                      showAlert = true
                      return
                  }
            
            DispatchQueue.main.async { // Correct
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                let decoder = JSONDecoder()
                
                print(String(data: responseData, encoding: .utf8))
                
                if let data = data, let userData = try? JSONDecoder().decode(UserModel.self, from: data) {
                    print("Fk myself")
                    
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
                    
                    let user = User(context: viewContext)
                    print("Mothher Fuckerrrrrrr\(userData.username)")
                    user.id = Int64(userData.id)
                    user.createdAt = Int64(userData.createdAt)
                    user.updatedAt = Int64(userData.updatedAt)
                    user.userID = userData.userID
                    user.coin = Int64(userData.coin)
                    user.username = userData.username
                    user.role = userData.role
                    
                    isLogin = true
                    isLogout = false
                    showAlert = true
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

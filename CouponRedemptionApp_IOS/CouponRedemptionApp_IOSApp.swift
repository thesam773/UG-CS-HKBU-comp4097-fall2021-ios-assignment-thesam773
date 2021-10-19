//
//  CouponRedemptionApp_IOSApp.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 13/10/2021.
//

import SwiftUI
import CoreData

@main
struct CouponRedemptionApp_IOSApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("shouldSeedData") var shouldSeedData: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: seedData)
        }
    }
}
struct CouponDataa: Identifiable {
    let createdAt: Int64
    let updatedAt: Int64
    let id: Int64
    let title: String
    let quota: Int64
    let coin: Int64
    let restaurant: String
    let expirydate: String
    let region: String
    let mall: String
    let image: String
    let detail: String
}

extension CouponDataa: Decodable {}

extension CouponRedemptionApp_IOSApp {
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    private func seedData() {
        
        if !shouldSeedData { return }
        var couponss: [CouponDataa] = []
        
        var couponArray: [[String:Any]] = []
        
        let couponMall: [[String : Any]] = [
            [
                "mall": "IFC Mall",
                "latitude": "22.2849",
                "longitude": "114.158917"
            ],
            [
                "mall": "Pacific Place",
                "latitude": "22.2774985",
                "longitude": "114.1663225"
            ],
            [
                "mall": "Times Square",
                "latitude": "22.2782079",
                "longitude": "114.1822994"
            ],
            [
                "mall": "Elements",
                "latitude": "22.3048708",
                "longitude": "114.1615219"
            ],
            [
                "mall": "Harbour City",
                "latitude": "22.2950689",
                "longitude": "114.1668661"
            ],
            [
                "mall": "Festival Walk",
                "latitude": "22.3372971",
                "longitude": "114.1745273"
            ],
            [
                "mall": "MegaBox",
                "latitude": "22.319857",
                "longitude": "114.208168"
            ],
            [
                "mall": "APM",
                "latitude": "22.3121738",
                "longitude": "114.22513219999996"
            ],
            [
                "mall": "Tsuen Wan Plaza",
                "latitude": "22.370735",
                "longitude": "114.111309"
            ],
            [
                "mall": "New Town Plaza",
                "latitude": "22.3814592",
                "longitude": "114.1889307"
            ]
        ]
        
//        let coupons: [[CouponData]]
        
        let viewContext = persistenceController.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        
        viewContext.performAndWait {
            let insertRequest = NSBatchInsertRequest(entity: CouponMall.entity(), objects: couponMall)
            
            let result = try? viewContext.execute(insertRequest) as? NSBatchInsertResult
            
            if let status = result?.result as? Int, status == 1 {
                print("Data Seeded")
                shouldSeedData = false
            }
        }
    }
}

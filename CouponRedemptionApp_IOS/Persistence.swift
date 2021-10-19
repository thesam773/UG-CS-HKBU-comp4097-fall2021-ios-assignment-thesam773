//
//  Persistence.swift
//  InfoDayJuly2021 (iOS)
//
//  Created by f0220952 on 7/10/2021.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
            let couponItem = CouponMall(context: viewContext)
            couponItem.mall = ["comp", "coms"].randomElement()
            couponItem.latitude = UUID().uuidString
            couponItem.longitude = UUID().uuidString
            
            let coupon = CouponData(context: viewContext)
            coupon.createdAt = 123
            coupon.updatedAt = 123
            coupon.id = 123
            coupon.title = ["comp", "coms"].randomElement()
            coupon.quota = 123
            coupon.coin = 123
            coupon.restaurant = UUID().uuidString
            coupon.expirydate = UUID().uuidString
            coupon.region = UUID().uuidString
            coupon.mall = UUID().uuidString
            coupon.image = UUID().uuidString
            coupon.detail = UUID().uuidString
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CouponRedemption")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

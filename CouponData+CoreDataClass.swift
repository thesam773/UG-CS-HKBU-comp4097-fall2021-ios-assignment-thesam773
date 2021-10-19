//
//  CouponData+CoreDataClass.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 17/10/2021.
//
//

import Foundation
import CoreData

@objc(CouponData)
public class CouponData: NSManagedObject {
//    enum CodingKeys: CodingKey {
//      case id
//    }
//
//    required convenience public init(from decoder: Decoder) throws {
//      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
//        throw DecoderConfigurationError.missingManagedObjectContext
//      }
//
//      self.init(context: context)
//
//      let container = try decoder.container(keyedBy: CodingKeys.self)
//      self.id = try container.decode(Int64.self, forKey: .id)
//    }
}

//init(createdAt: Int64, updatedAt: Int64, id: Int64,
//     title: String,
//     quota: Int64,
//     coin: Int64,
//     restaurant: String,
//     expirydate: String,
//     region: String,
//     mall: String,
//     image: String,
//     detail: String ) {
//    self.createdAt = createdAt
//    self.updatedAt = updatedAt
//    self.id = id
//    self.title = title
//    self.quota = quota
//    self.coin = coin
//    self.restaurant = restaurant
//    self.expirydate = expirydate
//    self.region = region
//    self.mall = mall
//    self.image = image
//    self.detail = detail
//
//}

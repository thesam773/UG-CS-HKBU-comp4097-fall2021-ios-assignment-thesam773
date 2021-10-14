//
//  Coupon.swift
//  CouponRedemptionApp_IOS
//
//  Created by Choi Chun Sing on 14/10/2021.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}

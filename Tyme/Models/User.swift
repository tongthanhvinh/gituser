//
//  User.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import Foundation
import SwiftData

@Model
final class User {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

//
//  Config.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import Foundation

enum Config {
    static let baseUrl: String = {
        if let url = ProcessInfo.processInfo.environment["BASE_URL"] {
            return url
        }
        return "https://api.github.com"
    }()
}

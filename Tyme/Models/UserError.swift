//
//  UserError.swift
//  Tyme
//
//  Created by Vinh Tong on 28/2/25.
//

import Foundation

struct UserError: Error {
    
    let code: Code
    
    init(_ code: Code) {
        self.code = code
    }
    
    struct Code: RawRepresentable, Hashable, Sendable {
        
        let rawValue: Int
        
        typealias RawValue = Int
        
        static let notFound: Code = Code(rawValue: 1)
    }
    
    var description: String {
        switch code {
        case .notFound: return "User Not found"
        default: return "Unknown error"
        }
    }
}

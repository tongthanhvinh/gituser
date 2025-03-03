//
//  TestError.swift
//  TymeTests
//
//  Created by Vinh Tong on 2/3/25.
//

import Foundation


enum TestError: Error {
    case apiError
    case mockError
    case noDetails
    case storageError
}

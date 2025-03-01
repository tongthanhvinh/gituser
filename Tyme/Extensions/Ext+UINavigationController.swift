//
//  Ext+UINavigationController.swift
//  Tyme
//
//  Created by Vinh Tong on 1/3/25.
//

import UIKit

// Allow swipe left to back for navigation stack
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

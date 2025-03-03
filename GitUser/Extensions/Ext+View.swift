//
//  Ext+View.swift
//  GitUser
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

extension View {
    func configBackButton(dismiss: DismissAction?) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss?() }) {
                        Image("arrow_left")
                            .renderingMode(.template)
                            .foregroundStyle(Color(.label))
                    }
                }
            }
    }
}

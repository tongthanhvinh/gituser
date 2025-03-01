//
//  HostingScreen.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct HostingScreen: View {
    
    @State private var path = [Int]([1])
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink("Tyme Home Test", value: 1)
                .navigationDestination(for: Int.self) { _ in UserListScreen() }
        }
    }
}

#Preview {
    HostingScreen()
}

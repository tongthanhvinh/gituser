//
//  HostingScreen.swift
//  GitUser
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI

struct HostingScreen: View {
    
    @State private var path: [Int] = [1]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                NavigationLink(value: 1) {
                    VStack {
                        Image("app_icon")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(22)
                        Text("OctopusHub")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color(.label))
                    }
                }
                .navigationDestination(for: Int.self) { _ in UserListScreen() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    HostingScreen()
}

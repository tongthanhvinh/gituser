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
            NavigationLink(value: 1) {
                VStack {
                    Image("app_icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(22)
                    Text("OctopusHub")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
            .navigationDestination(for: Int.self) { _ in UserListScreen() }
        }
    }
}

#Preview {
    HostingScreen()
}

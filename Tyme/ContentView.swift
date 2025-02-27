//
//  ContentView.swift
//  Tyme
//
//  Created by Vinh Tong on 27/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            
        }
    }
}

#Preview {
    ContentView()
}

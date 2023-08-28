//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Panagiotis Tsapanidis on 2023-08-28.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @State private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}

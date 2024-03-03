//
//  BucketListSUIApp.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

@main
struct BucketListSUIApp: App {
    @StateObject var dataStore = DataStore()
    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environmentObject(dataStore)
        }
    }
}

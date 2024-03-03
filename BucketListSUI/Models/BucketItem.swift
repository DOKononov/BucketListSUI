//
//  BucketItem.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import Foundation

struct BucketItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var note = ""
    var completedDate = Date.distantPast
    
    static var mock: [BucketItem] {
        [
        BucketItem(name: "Climbe Everest"),
        BucketItem(name: "Visit Hawaii", note: "Just some time"),
        BucketItem(name: "Buy Porsche 911", note: "Dream", completedDate: Date())
        ]
    }
}

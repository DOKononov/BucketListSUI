//
//  ItemDetailView.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var dataStore: DataStore
    @State var item: BucketItem
    
    var body: some View {
        Form {
            TextField("Bucket Note",
                      text: $item.note,
                      axis: .vertical)
            if item.completedDate != .distantPast {
                DatePicker("Completed on",
                           selection: $item.completedDate,
                           displayedComponents: .date)
            }
            Button(item.completedDate == .distantPast ?  "Add date" : "Clear date") {
                item.completedDate = (item.completedDate == .distantPast)
                ? Date()
                : .distantPast
            }
            .buttonStyle(.borderedProminent)
            
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.update(item)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(item.name)
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(item: BucketItem.mock[2])
            .environmentObject(DataStore())
    }
}

//
//  ItemDetailView.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject private var dataStore: DataStore
    let bucketItem: BucketItem
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form {
            TextField("Bucket Note", text: $note, axis: .vertical)
            if completedDate != .distantPast {
                DatePicker("Completed on",
                           selection: $completedDate,
                           displayedComponents: .date)
            }
            Button(completedDate == .distantPast ?  "Add date" : "Clear date") {
                completedDate = (completedDate == .distantPast) ? Date() : .distantPast
            }
            .buttonStyle(.borderedProminent)
            
        }
        .onAppear() {
            note = bucketItem.note
            completedDate = bucketItem.completedDate
        }
        .toolbar {
            ToolbarItem {
                Button("Update") {
                    dataStore.update(bucketItem: bucketItem,
                                     note: note,
                                     completedDate: completedDate)

                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(bucketItem.name)
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(bucketItem: BucketItem.mock[2])
            .environmentObject(DataStore())
    }
}

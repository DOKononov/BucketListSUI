//
//  ContentView.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

struct BucketListView: View {
    @EnvironmentObject private var dataStore: DataStore
    @State private var newItemName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New bucket", text: $newItemName)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        dataStore.create(newItemName)
                        newItemName = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItemName.isEmpty)
                }
                .padding()
                if !dataStore.bucketList.isEmpty {
                    List {
                        ForEach($dataStore.bucketList) { $item in
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .foregroundColor(
                                        item.completedDate == .distantPast ? .primary : .red)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: { indexSet in
                            dataStore.delete(at: indexSet)
                        })
                    }
                    .listStyle(.plain)

                } else {
                    EmptyStateView()
                }
            }
            .navigationTitle("Bucket List")
            .navigationDestination(for: BucketItem.self) { item in
                ItemDetailView(item: item)
            }
        }
    }
}

#Preview {
    BucketListView()
        .environmentObject(DataStore())
}

//
//  ContentView.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import SwiftUI

struct BucketListView: View {
    @EnvironmentObject private var dataStore: DataStore
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New bucket", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        dataStore.create(newItem)
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItem.isEmpty)
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
                            .onChange(of: item) { dataStore.saveList() }
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: { indexSet in
                            dataStore.delete(at: indexSet)
                        })
                    }
                    .listStyle(.plain)

                } else {
                    Text("List is empty. Add your first Bucket.")
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 80)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
            }
            .navigationTitle("Bucket List")
            .navigationDestination(for: BucketItem.self) { item in
                ItemDetailView(bucketItem: item)
            }
        }
    }
}

#Preview {
    BucketListView()
        .environmentObject(DataStore())
}

//
//  DataStore.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import Foundation

final class DataStore: ObservableObject {
    private let fileURL = URL.documentsDirectory.appendingPathExtension("bucketList.json")
    
    @Published var bucketList: [BucketItem] = [] { didSet { saveList() } }
    
    init() {
        loadItems()
    }
    
    private func loadItems() {
        do {
            let data =  try Data(contentsOf: fileURL)
            bucketList = try JSONDecoder().decode([BucketItem].self, from: data)
        } catch {
            print(error.localizedDescription)
            saveList()
        }
    }
    
    func create(_ newItem: String) {
        bucketList.append(BucketItem(name: newItem))
    }
    
    func delete(at indexSet: IndexSet) {
        bucketList.remove(atOffsets: indexSet)
    }
    
    func update(_ bucketItem: BucketItem) {
        if let index = (bucketList.firstIndex { $0.id == bucketItem.id}) {
            bucketList[index] = bucketItem
        }
    }
    
    private func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(bucketList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}

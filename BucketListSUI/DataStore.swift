//
//  DataStore.swift
//  BucketListSUI
//
//  Created by Dmitry Kononov on 3.03.24.
//

import Foundation

final class DataStore: ObservableObject {
    @Published var bucketList: [BucketItem] = []
    private let fileURL = URL.documentsDirectory.appendingPathExtension("bucketList.json")
    
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
        saveList()
    }
    
    func delete(at indexSet: IndexSet) {
        bucketList.remove(atOffsets: indexSet)
        saveList()
    }
    
    func update(bucketItem: BucketItem, note: String, completedDate: Date) {
        if let index = (bucketList.firstIndex { $0.id == bucketItem.id}) {
            bucketList[index].note = note
            bucketList[index].completedDate = completedDate
            saveList()
        }
    }
    
    func saveList() {
        do {
            let bucketListData = try JSONEncoder().encode(bucketList)
            let bucketListString = String(decoding: bucketListData, as: UTF8.self)
            try bucketListString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}

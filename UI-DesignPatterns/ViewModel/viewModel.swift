//
//  viewModel.swift
//  UI-DesignPatterns
//
//  Created by Sparkout on 13/06/24.
//

import Foundation

class ViewModel {
    private var items = [Item]()
    private var currentPage = 1
        
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData(page: currentPage) { [weak self] items, error in
            guard let self = self else { return }
            if let items = items {
            self.items.append(contentsOf: items)
                print("Items appended:", self.items)
            self.currentPage += 1
            }
            completion()
            }
        }
        
        func numberOfItems() -> Int {
            print("Number of items:", items.count)
            return items.count
        }
        
        func item(at index: Int) -> Item {
            return items[index]
        }
}

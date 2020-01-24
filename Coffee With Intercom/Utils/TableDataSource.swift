//
//  TableDataSource.swift
//
//  Created by Kalpesh Talkar on 15/11/19.
//  Copyright © 2019 Kalpesh Talkar. All rights reserved.
//

import UIKit

class TableDataSource<T>: NSObject, UITableViewDataSource {
    
    typealias TableCellBlock<T> = (T, IndexPath) -> (UITableViewCell)
    
    private var data: [T] = []
    private var cellBlock: TableCellBlock<T>!
    
    private var tableView: UITableView!
    
    func add(item: T, at index: Int? = nil) {
        if let i = index {
            add(items: [item], at: i)
        } else {
            add(items: [item])
        }
    }
    
    func add(items: [T], at index: Int? = nil) {
        if let i = index {
            data.insert(contentsOf: items, at: i)
        } else {
            data.append(contentsOf: items)
        }
    }
    
    func setData(items: [T]) {
        removeAll()
        add(items: items)
    }
    
    func remove(at index: Int) {
        data.remove(at: index)
    }
    
    func removeAll() {
        data.removeAll()
    }
    
    func item(at: Int) -> T {
        return data[at]
    }
    
    var count: Int {
        return data.count
    }
    
    init(with data: [T], cellBlock: @escaping TableCellBlock<T>) {
        super.init()
        self.data = data
        self.cellBlock = cellBlock
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellBlock(data[indexPath.row], indexPath)
    }
    
}

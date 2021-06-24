//
//  ThreadSafeArray.swift
//  Chat2chat
//
//  Created by Oleksiy on 24.06.2021.
//

import Foundation

class ThreadSafeArray<T> {
    private var data = [T]()
    private let queue = DispatchQueue(label: "data.append.and.read", attributes: .concurrent)
    
    func append(_ data: T) {
        queue.async(flags: .barrier) { [weak self] in
            self?.data.append(data)
        }
    }
    
    func append(contentsOf data: [T]) {
        queue.async(flags: .barrier) { [weak self] in
            self?.data.append(contentsOf: data)
        }
    }
    
    func remove(at index: Int) {
        queue.async(flags: .barrier) {  [weak self] in
            if self?.data.count ?? 0 > index {
                self?.data.remove(at: index)
            }
        }
    }
    
    func removeAll() {
        queue.async(flags: .barrier) {  [weak self] in
            self?.data.removeAll()
        }
    }
    
    func get(index: Int) -> T? {
        var readData: T?
        queue.sync {
            if index < data.count {
                readData = data[index]
            }
        }
        return readData
    }
    
    var count: Int {
        var currentCount = 0
        queue.sync {
            currentCount = data.count
        }
        return currentCount
    }
}

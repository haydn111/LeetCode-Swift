//
//  SimpleWebImage.swift
//  collectionviewdemo
//
//  Created by Su Yan on 5/19/18.
//  Copyright © 2018 Su Yan. All rights reserved.
//
import Foundation

class LRUCache<String, V> {
    private var lruSize = 10
    private let queue = DispatchQueue(label: "lru_queue", attributes: .concurrent)
    var cache = [String: V]()
    var order = NSMutableOrderedSet()  // set of keys, oldest to newest, add/remove in O(1)

    convenience init(size: Int) {
        self.init()
        self.lruSize = size
    }

    func put(_ value: V, for key: String) {
        queue.async(flags: .barrier) {
            self.cache[key] = value
            self.order.add(NSString(string: key))
            if self.order.count > self.lruSize {
                self.cache[self.order.object(at: 0) as! NSString as String] = nil
                self.order.removeObject(at: 0)
            }
        }
    }

    func get(_ key: String) -> V? {
        var value: V?
        queue.sync {
            value = cache[key]
            if value != nil {
                self.order.remove(NSString(string: key))
                self.order.add(NSString(string: key))
            }
        }
        return value
    }
}


/**
 DatabaseQuery.swift
 created by D.ace on 21/04/2017
 */

import Foundation
import RealmSwift

class DatabaseQuery<T: Object> {
    
    fileprivate var table: Results<T>?
    
    init(table: Results<T>) {
        self.table = table
    }
    
    init() {
    }
    
    func isAvailable() -> Bool {
        return table != nil
    }
    
    func sortedBy(_ property: String, ascending: Bool = false) -> DatabaseQuery<T> {
        if isAvailable() {
            table = table!.sorted(byKeyPath: property, ascending: ascending)
        }
        return self
    }
    
    func sortedById(withAscending ascending: Bool) -> DatabaseQuery<T> {
        return sortedBy("id", ascending: ascending)
    }
    
    func getById(_ id: Int) -> T? {
        if isAvailable() {
            return when("id = \(id)").table!.first
        }
        return nil
    }
    
    func getByStringId(_ id: String) -> T? {
        if isAvailable() {
            return when("id = '\(id)'").table!.first
        }
        return nil
    }
    
    func when(_ condition: String) -> DatabaseQuery<T> {
        if isAvailable() {
            table = table!.filter(condition)
        }
        return self
    }
    
    func when(_ predicate: NSPredicate) -> DatabaseQuery<T> {
        if isAvailable() {
            table = table!.filter(predicate)
        }
        return self
    }
    
    var results: [T] {
        if isAvailable() {
            return table!.toArray(T.self)
        }
        return []
    }
    
    var result: T? {
        if isAvailable() {
            return table!.first
        }
        return nil
    }
    
}

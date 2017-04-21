/**
 DatabaseSession.swift
 created by D.ace on 21/04/2017
 */

import Foundation
import RealmSwift

class DatabaseSession {
    
    class func mainSession() -> DatabaseSession {
        return DatabaseMaster.mainDatabaseSession
    }
    
    internal var isReady = false
    internal var realmDB: Realm?
    
    func openSession() {
        do {
            realmDB = try Realm()
            isReady = true
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    func closeSession() {
        realmDB = nil
        isReady = false
    }
    
    func isSessionReady() -> Bool {
        return isReady && realmDB != nil
    }
    
    func writeObject<T: Object>(_ object: T) -> Bool {
        guard isSessionReady() else {
            return false
        }
        if realmDB!.isInWriteTransaction {
            realmDB!.add(object, update: true)
            return true
        }
        realmDB!.beginWrite()
        realmDB!.add(object, update: true)
        do {
            try realmDB!.commitWrite()
            return true
        } catch {
            print("Realm error: \(error)")
        }
        return false
    }
    
    func writeObjects<T: Object>(_ objects: [T]) -> Bool {
        guard isSessionReady() && objects.count > 0 else {
            return false
        }
        if realmDB!.isInWriteTransaction {
            realmDB!.add(objects, update: true)
            return true
        }
        realmDB!.beginWrite()
        realmDB!.add(objects, update: true)
        do {
            try realmDB!.commitWrite()
            return true
        } catch {
            print("Realm error: \(error)")
        }
        return false
    }
    
    func openTransaction(_ writeBlock: (() -> Void)) {
        guard isSessionReady() else {
            return
        }
        do {
            try realmDB!.write(writeBlock)
        } catch {
            print("Realm error: \(error)")
        }
    }
    
    func deleteObject<T: Object>(_ object: T) -> Bool {
        guard isSessionReady() else {
            return false
        }
        if object.isInvalidated {
            return false
        }
        if realmDB!.isInWriteTransaction {
            realmDB!.delete(object)
            return true
        }
        realmDB!.beginWrite()
        realmDB!.delete(object)
        do {
            try realmDB!.commitWrite()
            return true
        } catch {
            print("Realm error: \(error)")
        }
        return false
    }
    
    func deleteObjects<T: Object>(_ objects: [T]) -> Bool {
        guard isSessionReady() else {
            return false
        }
        if realmDB!.isInWriteTransaction {
            realmDB!.delete(objects)
            return true
        }
        realmDB!.beginWrite()
        realmDB!.delete(objects)
        do {
            try realmDB!.commitWrite()
            return true
        } catch {
            print("Realm error: \(error)")
        }
        return false
    }
    
    func deleteAll() -> Bool {
        if realmDB!.isInWriteTransaction {
            realmDB!.deleteAll()
            return true
        }
        realmDB!.beginWrite()
        realmDB!.deleteAll()
        do {
            try realmDB!.commitWrite()
            return true
        } catch {
            print("Realm error: \(error)")
        }
        return false
    }
    
    func queryForObjects<T: Object>(_ classType: T.Type) -> DatabaseQuery<T> {
        guard isSessionReady() else {
            return DatabaseQuery<T>()
        }
        return DatabaseQuery<T>(table: realmDB!.objects(T.self))
    }
    
}

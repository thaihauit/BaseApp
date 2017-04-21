/**
 DatabaseMaster.swift
 created by D.ace on 21/04/2017
 */

import Foundation
import RealmSwift

class DatabaseMaster {
    
    static let sharedInstance = DatabaseMaster()
    
    static let databaseVersion: UInt64 = 201704211200
    static let deleteDatabaseIfMigrationNeeded = false
    static let mainDatabaseSession = DatabaseSession()
    
    func create() {
        // Realm schema version
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = DatabaseMaster.databaseVersion
        config.migrationBlock = { (migration, oldSchemaVersion) in
            // Database migration
            DispatchQueue.main.async(execute: {
                if UserUseCase.getCurrentUser() == nil {
                    CacheManager.cleanUpCachedFiles()
                }
            })
        }
        config.deleteRealmIfMigrationNeeded = DatabaseMaster.deleteDatabaseIfMigrationNeeded
        Realm.Configuration.defaultConfiguration = config
        DatabaseMaster.mainDatabaseSession.openSession()
    }
    
    func createForTest(_ testSessionName: String) {
        var config = Realm.Configuration.defaultConfiguration
        config.inMemoryIdentifier = testSessionName
        Realm.Configuration.defaultConfiguration = config
        DatabaseMaster.mainDatabaseSession.openSession()
    }
    
}

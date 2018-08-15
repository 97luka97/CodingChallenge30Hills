//
//  UserPersister.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/15/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

protocol UserPersistable {
    func getAllUsers(completion: @escaping ([User]) -> Void)
    func save(users: [User])
}

import Foundation
import UIKit
import CoreData

class UserPersister: UserPersistable {
    
    //MARK: - Properties
    
    static let shared = UserPersister()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - Public methods
    
    func getAllUsers(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                if let resultsManagedObject = results as? [NSManagedObject] {
                    resultsManagedObject.forEach { (object) in
                        users.append(User(id: object.value(forKey: "id") as! Int, firstName: object.value(forKey: "firstName") as! String, surname: object.value(forKey: "surname") as! String, age: object.value(forKey: "age") as? Int, gender: object.value(forKey: "gender") as! String, friends: object.value(forKey: "friends") as! [Int]))
                    }
                    completion(users)
                }
            }
        } catch {
            completion([])
        }
    }
    
    func save(users: [User]) {
        let context = appDelegate.persistentContainer.viewContext
        deleteSavedUsers()
        users.forEach { (user) in
            let userEntity = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            userEntity.setValue(user.id, forKey: "id")
            userEntity.setValue(user.firstName, forKey: "firstName")
            userEntity.setValue(user.surname, forKey: "surname")
            userEntity.setValue(user.age, forKey: "age")
            userEntity.setValue(user.gender, forKey: "gender")
            userEntity.setValue(user.friends, forKey: "friends")
            do {
                try context.save()
            } catch {

            }
        }
    }
    
    //MARK: - Private methods
    
    private func deleteSavedUsers() {
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                if let resultsManagedObject = results as? [NSManagedObject] {
                    resultsManagedObject.forEach { (managedObject) in
                        context.delete(managedObject)
                    }
                    do {
                        try context.save()
                    } catch {
                        
                    }
                }
            }
        } catch {
            
        }
    }
    
}

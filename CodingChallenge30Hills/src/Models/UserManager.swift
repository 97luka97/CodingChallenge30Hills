//
//  UserManager.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/15/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

class UserManager {
    
    // MARK: - Properties
    
    var userPersister: UserPersistable
    var userService: UserServiceable
    
    // MARK: - Init methods
    
    init(userPersister: UserPersistable, userService: UserServiceable) {
        self.userPersister = userPersister
        self.userService = userService
    }
    
    // MARK: - Public Methods
    
    
    func getAllUsers(completion: @escaping ([User]) -> Void) {
        userService.getUsers { [weak self] (response) in
            if response.success {
                if let users = response.object {
                    self?.userPersister.save(users: users)
                    completion(users)
                }
            } else {
                if let _self = self {
                    _self.userPersister.getAllUsers(completion: { (users) in
                        completion(users)
                    })
                }
            }
        }
    }

}

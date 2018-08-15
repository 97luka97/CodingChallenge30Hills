//
//  FriendsOfFriends.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/15/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

struct FriendsOfFriends {
    
    // MARK: - Properties
    
    var userId: Int
    var directFriendsIds: [Int]
    var allUsers: [User]
    
    //MARK: - Init methods
    
    init(userId: Int, directFriendsIds: [Int], allUsers: [User]) {
        self.userId = userId
        self.directFriendsIds = directFriendsIds
        self.allUsers = allUsers
    }
    
    //MARK: - Public methods
    
    func getFriendsOfMyDirectFriends() -> [User] {
        return allUsers.filter { getIdsOfAllFriendsOfMyDirectFriends().contains($0.id) }
    }
    
    //MARK: Private methods
    
    private func getIdsOfAllFriendsOfMyDirectFriends() -> [Int] {
        var setOfAllFriendsOfMyDirectFriendsIds = Set<Int>()
        returnUsers(withIds: directFriendsIds).filter { !isMyself(userWithId: $0.id) }.forEach { setOfAllFriendsOfMyDirectFriendsIds.insert($0.id)}
        return Array(setOfAllFriendsOfMyDirectFriendsIds)
    }
    
    private func returnUsers(withIds ids: [Int]) -> [User] {
       return allUsers.filter { ids.contains($0.id) }
    }
    
    private func isMyself(userWithId userId: Int) -> Bool {
        return self.userId == userId
    }
}

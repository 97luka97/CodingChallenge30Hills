//
//  SuggestedFriends.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/15/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

struct SuggestedFriends {
    
    // MARK: - Properties
    
    var user: User
    var allUsers: [User]
    
    // MARK: - Init methods
    
    init(user: User, allUsers: [User]) {
        self.user = user
        self.allUsers = allUsers
    }
    
    // MARK: - Public methods
    
    func returnAllSuggestedFriends() -> [User] {
        var suggestedFriends = [User]()
        if hasRequiredNumberOfFriends() {
            allUsers.forEach { (user) in
                if !isFriend(ofUser: user) && !isMyself(user: user) {
                    if hasRequiredNumberOfFriendsInCommon(user: user) {
                        suggestedFriends.append(user)
                    }
                }
            }
        }
        return suggestedFriends
    }
    
    // MARK: - Private methods
    
    private func directFriendsIds(ofUser user: User) -> Set<Int> {
        var result = Set<Int>()
        user.friends.forEach { result.insert($0) }
        return result
    }
    
    private func isMyself(user: User) -> Bool {
        return self.user.id == user.id
    }
    
    private func hasRequiredNumberOfFriends() -> Bool {
        return user.friends.count >= 1
    }
    
    private func isFriend(ofUser user: User) -> Bool {
        return self.user.friends.contains(user.id)
    }
    
    private func hasRequiredNumberOfFriendsInCommon(user: User) -> Bool {
        let directFriendsIdsofSelectedUser = directFriendsIds(ofUser: self.user)
        let directFriendsIdsofPassedUser = directFriendsIds(ofUser: user)
        
        return directFriendsIdsofPassedUser.intersection(directFriendsIdsofSelectedUser).count >= 2
    }
}

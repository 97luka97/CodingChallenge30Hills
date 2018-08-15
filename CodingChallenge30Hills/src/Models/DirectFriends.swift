//
//  DirectFriends.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/15/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

struct DirectFriends {
    
    //MARK: - Properties
    
    private var allUsers: [User]
    private var directFriendIds: [Int]
    
    //MARK: - Init methods
    
    init(allUsers: [User], directFriendIds: [Int]) {
        self.allUsers = allUsers
        self.directFriendIds = directFriendIds
    }
    
    //MARK: - Public methods
    
    func getAllDirectFriends() -> [User] {
        return allUsers.filter { directFriendIds.contains($0.id) }
    }
    
    func getAllDirectFriendsIds() -> [Int] {
        var setOfAllFriendsOfDirectFriendsIds = Set<Int>()
        getAllDirectFriends().forEach { $0.friends.forEach({ (friendId) in
            setOfAllFriendsOfDirectFriendsIds.insert(friendId)
        }) }
        return Array(setOfAllFriendsOfDirectFriendsIds)
    }
    
}

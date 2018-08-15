//
//  AllUsersViewController.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/14/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import UIKit

class AllUsersViewController: UIViewController {
    
    private struct Segue {
        static let filteredUsersViewController = "segueToFilteredUsersViewController"
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    var users = [User]()
    let userManager = UserManager(userPersister: UserPersister.shared, userService: NetworkingService.shared)
    
    //MARK: - View Life cycle 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
    }
    
    //MARK: - Override Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.filteredUsersViewController {
            if let destinationViewController = segue.destination as? FilteredUsersViewController, let selectedIndex = sender as? Int {
                let directFriends = DirectFriends(allUsers: users, directFriendIds: users[selectedIndex].friends)
                let user = users[selectedIndex]
                destinationViewController.user = user
                destinationViewController.directFriends = directFriends.getAllDirectFriends()
                destinationViewController.friendsOfFriends = FriendsOfFriends(userId: user.id, directFriendsIds: directFriends.getAllDirectFriendsIds(), allUsers: users).getFriendsOfMyDirectFriends()
                destinationViewController.suggestedFriends = SuggestedFriends(user: user, allUsers: users).returnAllSuggestedFriends()
            }
        }
    }
    
    //MARK: - Private Methods
    
    private func getUsers() {
        userManager.getAllUsers { [weak self] (users) in
            self?.users = users
            self?.tableView.reloadData()
        }
    }
}

//MARK: - UITableView

extension AllUsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicInfoCellIdentifier", for: indexPath) as! BasicInfoTableViewCell
        
        cell.labelName.text = users[indexPath.row].firstName
        cell.labelSurname.text = users[indexPath.row].surname
        cell.labelGender.text = users[indexPath.row].gender
        cell.labelAge.text = users[indexPath.row].age != nil ? String(users[indexPath.row].age!) + "," : ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Segue.filteredUsersViewController, sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

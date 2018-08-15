//
//  FilteredUsersViewController.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/14/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import UIKit

class FilteredUsersViewController: UIViewController {
    
    enum FriendConnectionType: Int {
        case directFriends = 0
        case friendsOfFriends
        case suggestedFriends
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var supplementaryLabel: UILabel!
    @IBOutlet weak var labelNameAndSurname: UILabel!
    
    //MARK: - Properties
    
    var user: User!
    var directFriends: [User]!
    var friendsOfFriends: [User]!
    var suggestedFriends: [User]!
    
    //MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        labelNameAndSurname.text = user.firstName + " " + user.surname
        supplementaryLabel.text = user.age != nil ? String(user.age!) + ", " + user.gender : user.gender
    }
}

//MARK: - UITableView

extension FilteredUsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendConnectionType = FriendConnectionType.init(rawValue: section)!
        
        switch friendConnectionType {
            
        case .directFriends:
            return directFriends.count
        case .friendsOfFriends:
            return friendsOfFriends.count
        case .suggestedFriends:
            return suggestedFriends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicInfoCellIdentifier", for: indexPath) as! BasicInfoTableViewCell
        
        let friendConnectionType = FriendConnectionType.init(rawValue: indexPath.section)!
        
        switch friendConnectionType {
            
        case .directFriends:
            cell.labelName.text = directFriends[indexPath.row].firstName
            cell.labelSurname.text = directFriends[indexPath.row].surname
            cell.labelGender.text = directFriends[indexPath.row].gender
            cell.labelAge.text = directFriends[indexPath.row].age != nil ? String(directFriends[indexPath.row].age!) + "," : ""
            return cell
        case .friendsOfFriends:
            cell.labelName.text = friendsOfFriends[indexPath.row].firstName
            cell.labelSurname.text = friendsOfFriends[indexPath.row].surname
            cell.labelGender.text = friendsOfFriends[indexPath.row].gender
            cell.labelAge.text = friendsOfFriends[indexPath.row].age != nil ? String(friendsOfFriends[indexPath.row].age!) + "," : ""
            return cell
        case .suggestedFriends:
            cell.labelName.text = suggestedFriends[indexPath.row].firstName
            cell.labelSurname.text = suggestedFriends[indexPath.row].surname
            cell.labelGender.text = suggestedFriends[indexPath.row].gender
            cell.labelAge.text = suggestedFriends[indexPath.row].age != nil ? String(suggestedFriends[indexPath.row].age!) + "," : ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let friendConnectionType = FriendConnectionType.init(rawValue: section)!
        
        switch friendConnectionType {
            
        case .directFriends:
            return "direct Friends"
        case .friendsOfFriends:
            return "friends Of Friends"
        case .suggestedFriends:
            return "suggested Friends"
        }
    }
}

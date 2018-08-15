//
//  NetworkingService.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/14/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

protocol UserServiceable {
    func getUsers(completion: @escaping APIResponseCallBack)
}

import Foundation

class NetworkingService: UserServiceable {
    
    //MARK: - Properties
    
    static let shared = NetworkingService()
    
    //MARK: - Public Methods
    
    func getUsers(completion: @escaping APIResponseCallBack) {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            
            if let filePath = Bundle(for: type(of: self)).path(forResource: "users", ofType: "txt") {
                let json = try! String(contentsOfFile: filePath).data(using: .utf8)
                
                do {
                    let users = try JSONDecoder().decode([User].self, from: json!)
                    completion(APIResponse(success: true, object: users))
                } catch {
                    completion(APIResponse(success: false))
                }
                
            }
        }
    }
    
}

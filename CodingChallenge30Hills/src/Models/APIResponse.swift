//
//  APIResponse.swift
//  CodingChallenge30Hills
//
//  Created by Kostic on 8/14/18.
//  Copyright © 2018 Kostic. All rights reserved.
//

import Foundation

typealias APIResponseCallBack = (APIResponse) -> Void

struct APIResponse {
    
    //MARK: - Properties
    
    var success: Bool
    var error: Error?
    var object: [User]?
    
    //MARK: - Init methods
    
    init(success: Bool, error: Error? = nil, object: [User]? = nil) {
        
        self.success = success
        self.error = error
        self.object = object
    }
}

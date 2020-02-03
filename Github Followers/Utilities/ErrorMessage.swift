//
//  ErrorMessages.swift
//  Github Followers
//
//  Created by Vivek Rai on 22/01/20.
//  Copyright © 2020 Vivek Rai. All rights reserved.
//

import Foundation

enum GFError: String, Error{
    
    case invalidUsername = "The username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Inavlid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    
}

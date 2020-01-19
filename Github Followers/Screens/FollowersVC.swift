//
//  FollowersVC.swift
//  Github Followers
//
//  Created by Vivek Rai on 19/01/20.
//  Copyright © 2020 Vivek Rai. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

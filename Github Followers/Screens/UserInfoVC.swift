//
//  UserInfoVC.swift
//  Github Followers
//
//  Created by Vivek Rai on 24/01/20.
//  Copyright © 2020 Vivek Rai. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton 
    }

    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

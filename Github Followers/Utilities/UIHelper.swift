//
//  UIHelper.swift
//  Github Followers
//
//  Created by Vivek Rai on 23/01/20.
//  Copyright © 2020 Vivek Rai. All rights reserved.
//

import UIKit

struct UIHelper{
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
       let width = view.bounds.width
       let padding: CGFloat = 12
       let minimumInterItemSpacing: CGFloat = 10
       let availableWidth = width - (padding*2) - (minimumInterItemSpacing*2)
       let itemWidth = availableWidth/3
       
       let flowLayout = UICollectionViewFlowLayout()
       flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
       flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
       return flowLayout
    }
}



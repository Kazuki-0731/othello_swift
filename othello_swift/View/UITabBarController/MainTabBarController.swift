//
//  File.swift
//  othello_swift
//
//  Created by Kazuki on 2020/07/26.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

import UIKit
 
class MainTabBarController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色
        tabBar.barTintColor = UIColor.black
        // アイテムの色
        tabBar.tintColor = UIColor.white
    }
}

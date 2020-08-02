//
//  MainNavigationController.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/07/26.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit
 
class MainNavigationController: UINavigationController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // 背景色
        navigationBar.barTintColor = UIColor.black
        // アイテムの色
        navigationBar.tintColor = UIColor.white
        // テキスト
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
 


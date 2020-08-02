//
//  HomeViewController.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/07/26.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

import UIKit
 
class HomeViewController: UIViewController, OthelloBoardLayoutDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource:OthelloBoardDataSource = OthelloBoardDataSource()
    var delegate:OthelloBoardDelegate = OthelloBoardDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // オセロのデータと通知
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate

        // オセロ盤面のレイアウト
        let customLayout = OthelloBoardLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
    }
 
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(38)
    }
}

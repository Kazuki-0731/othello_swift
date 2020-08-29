//
//  HomeViewController.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/07/26.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

import UIKit
import SVGKit
 
class HomeViewController: UIViewController, OthelloBoardLayoutDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondPoint: UILabel!
    @IBOutlet weak var initiative: UIImageView!
    @IBOutlet weak var firstPoint: UILabel!

    var dataSource:OthelloBoardDataSource = OthelloBoardDataSource()
    var delegate:OthelloBoardDelegate = OthelloBoardDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 外部からのアクセス許可
        delegate.homeView = self
        
        // オセロのデータと通知
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = delegate
        
        // 盤面のセル
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")

        // オセロ盤面のレイアウト
        let customLayout = OthelloBoardLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
        
        guard let svgImage = SVGKImage(named: "right_arrow") else {
            return
        }
        svgImage.size = initiative.frame.size
        initiative.image = svgImage.uiImage
    }
 
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(38)
    }
}

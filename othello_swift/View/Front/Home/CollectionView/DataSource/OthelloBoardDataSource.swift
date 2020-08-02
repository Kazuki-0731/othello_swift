//
//  OthelloBoardDataSource.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/02.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

class OthelloBoardDataSource: NSObject, UICollectionViewDataSource {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        cell.highlightView.backgroundColor = .green
        cell.frame.size.width = 38
        cell.frame.size.height = 38
        
        // 選択された箇所を青くする
//        let selectedBGView = UIView(frame: cell.frame)
//        selectedBGView.backgroundColor = .blue
//        cell.selectedBackgroundView = selectedBGView

        return cell
    }
}


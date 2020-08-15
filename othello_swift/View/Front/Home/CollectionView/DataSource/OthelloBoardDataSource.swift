//
//  OthelloBoardDataSource.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/02.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

/// オセロ配置
/// 00 01 02 03 04 05 06 07
/// 08 09 10 11 12 13 14 15
/// 16 17 18 19 20 21 22 23
/// 24 25 26 27 28 29 30 31
/// 32 33 34 35 36 37 38 39
/// 40 41 42 43 44 45 46 47
/// 48 49 50 51 52 53 54 55
/// 56 57 58 59 60 61 62 63
/// 上下左右左上右上左下右下の処理(allocable)
/// 北西:-7
/// 北:-8
/// 北東:-9
/// 南西:+7
/// 南:+8
/// 南東:+9
/// 西:+1
/// 東:-1

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
        
        /// 初期盤面
        if(OthelloData.shared.isStart){
            print("indexPath : \(indexPath)")
            if(OthelloInital.blackArrangement.contains(indexPath.row)){
                cell.highlightView.backgroundColor = .black
                OthelloData.firstArray = OthelloInital.blackArrangement
            } else if(OthelloInital.whiteArrangement.contains(indexPath.row)){
                cell.highlightView.backgroundColor = .white
                OthelloData.secondArray = OthelloInital.whiteArrangement
            }
        }
        
        return cell
    }
}


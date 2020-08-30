//
//  OthelloLogicProtocol.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import UIKit

protocol OthelloProtocol {
    /// 配置できる場所を返す
    func allocable(cell:CollectionViewCell, current: Int) -> [Azimuth]
    
    /// 探索可能領域をグレーに
    func battlableAreaDisplay(collectionView: UICollectionView)
}

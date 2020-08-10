//
//  OthelloLogic.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

class OthelloLogic : OthelloProtocol{
    // 配置できる場所を返す
    static func allocable(cell:CollectionViewCell, current: Int) -> [Azimuth] {
        // 緑の箇所であるのか？
        if(cell.highlightView.backgroundColor == .green){
            return [Azimuth.WEST]
        }
        return []
    }
}

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
            var directionArray: [Azimuth] = []
            //上下左右左上右上左下右下ですでにオセロが置いてあるのか
            for direction in Azimuth.allCases {
                if(OthelloData.shared.secondArray.contains(current + searchOthello(direction: direction))){
                    directionArray.append(direction)
                }
            }
            return directionArray
        }
        return []
    }
    
    //
    static func aaaa(index: Int) -> Bool{
        return OthelloInital.init().westWallEdge.contains(1)
    }
    
    // 1マス隣の方位から差分を返す
    static func searchOthello(direction: Azimuth) -> Int{
        switch direction {
            case .EAST:
                return -1
            case .NORTHWEST:
                return -7
            case .NORTH:
                return -8
            case .NORTHEAST:
                return -9
            case .SOUTHWEST:
                return +7
            case .SOUTH:
                return +8
            case .SOUTHEAST:
                return +9
            case .WEST:
                return +1
        }
    }
}

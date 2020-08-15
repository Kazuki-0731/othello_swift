//
//  OthelloLogic.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

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
class OthelloLogic : OthelloProtocol{
    // 配置できる場所を返す
    static func allocable(cell:CollectionViewCell, current: Int) -> [Azimuth] {
        // 緑の箇所であるのか？
        if(cell.highlightView.backgroundColor == .green){
            var directionArray: [Azimuth] = []
            //上下左右左上右上左下右下ですでにオセロが置いてあるのか
            for direction in Azimuth.allCases {
                // 現在のオセロの位置
                var searchIndex = current
                var foundEnemy = false
                searchIndex = searchIndex + OthelloLogic.searchOthello(direction: direction)
                if(OthelloData.isFirst){
                    // その方角に相手のマスがある
                    if(OthelloData.secondArray.contains(searchIndex)){
                        foundEnemy = true
                    }
                } else {
                    // その方角に相手のマスがある
                    if(OthelloData.firstArray.contains(searchIndex)){
                        foundEnemy = true
                    }
                }
                // 壁まで検索
                while(foundEnemy){
                    if(OthelloData.isFirst){
                        // その方角に相手のマスがある
                        if(OthelloData.secondArray.contains(searchIndex)){
                            var loop = current
                            // その直線状を自分の陣地があるまで探索
                            while(true) {
                                loop = loop + OthelloLogic.searchOthello(direction: direction)
                                // 自分の陣地がある
                                if OthelloData.firstArray.contains(loop) {
                                    directionArray.append(direction)
                                    break
                                }
                                // 壁まで行ったらbreak
                                if(OthelloInital.wallEdge.contains(loop)){
                                    break
                                } else if (loop < 0 || loop > 63){
                                    break
                                }
                            }
                        }
                    } else {
                        // その方角に相手のマスがある
                        if(OthelloData.firstArray.contains(searchIndex)){
                            var loop = current
                            // その直線状を調べる
                            while(true) {
                                loop = loop + OthelloLogic.searchOthello(direction: direction)
                                // 自分の陣地がある
                                if OthelloData.secondArray.contains(loop) {
                                    directionArray.append(direction)
                                    break
                                }
                                // 壁まで行ったらbreak
                                if(OthelloInital.wallEdge.contains(loop)){
                                    break
                                } else if (loop < 0 || loop > 63){
                                    break
                                }
                            }
                        }
                    }
                    // 壁まで行ったらbreak
                    if(OthelloInital.wallEdge.contains(searchIndex)){
                        break
                    } else if (searchIndex < 0 || searchIndex > 63){
                        break
                    }
                    searchIndex = searchIndex + OthelloLogic.searchOthello(direction: direction)
                }
            }
            return directionArray
        }
        return []
    }
        
    // 1マス隣の方位から差分を返す
    static func searchOthello(direction: Azimuth) -> Int{
        switch direction {
            case .WEST:
                return -1
            case .NORTHWEST:
                return -9
            case .NORTH:
                return -8
            case .NORTHEAST:
                return -7
            case .SOUTHWEST:
                return +7
            case .SOUTH:
                return +8
            case .SOUTHEAST:
                return +9
            case .EAST:
                return +1
        }
    }
}

//
//  OthelloLogic.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

/// オセロ配置
/// 00 | 01 02 03 04 05 06 07 08 | 09
/// ---------------------------------
/// 10 | 11 12 13 14 15 16 17 18 | 19
/// 20 | 21 22 23 24 25 26 27 28 | 29
/// 30 | 31 32 33 34 35 36 37 38 | 39
/// 40 | 41 42 43 44 45 46 47 48 | 49
/// 50 | 51 52 53 54 55 56 57 58 | 59
/// 60 | 61 62 63 64 65 66 67 68 | 69
/// 70 | 71 72 73 74 75 76 77 78 | 79
/// 80 | 81 82 83 84 85 86 87 88 | 89
/// ---------------------------------
/// 90 | 91 92 93 94 95 96 97 98 | 99
/// 上下左右左上右上左下右下の処理(allocable)
/// 北西:-9
/// 北:-8
/// 北東:-7
/// 南西:+7
/// 南:+8
/// 南東:+9
/// 西:-1
/// 東:+1
///
class OthelloLogic : OthelloProtocol{
    // 方位配列
    static var directionArray: [Azimuth] = []
    // 探索するオセロの位置
    static var searchIndex: Int!
    // 隣に相手があるのか
    var foundEnemy: Bool!
    // 直線状に自分の陣地があるのか
    var notFoundMe: Bool!

    init() {
        OthelloLogic.searchIndex = 0
    }

    // 配置できる場所を返す
    func allocable(cell:CollectionViewCell, current: Int) -> [Azimuth] {
        // 緑の箇所であるのか？
        if(cell.highlightView.backgroundColor == .green){
            OthelloLogic.directionArray = []
            //上下左右左上右上左下右下ですでにオセロが置いてあるのか
            for direction in Azimuth.allCases {
                // 隣に相手があるのか
                foundEnemy = false
                // 直線状に自分の陣地があるのか
                notFoundMe = true
                // 探索するオセロの位置
                OthelloLogic.searchIndex = current
                OthelloLogic.searchIndex = OthelloLogic.searchIndex + OthelloLogic.searchOthello(direction: direction)
                if(OthelloData.isFirst){
                    // その方角に相手のマスがある
                    foundEnemy = OthelloData.secondArray.contains(OthelloLogic.searchIndex)
                } else {
                    // その方角に相手のマスがある
                    foundEnemy = OthelloData.firstArray.contains(OthelloLogic.searchIndex)
                }
                // 自分の陣地まで
                while(foundEnemy && notFoundMe){
                    if(OthelloData.isFirst){
                        // その方角に先攻のマスがある
                        is_there_a_first_strikes_trout_in_that_direction(direction: direction, current: current)
                    } else {
                        // その方角に後攻のマスがある
                        is_there_a_second_strikes_trout_in_that_direction(direction: direction, current: current)
                    }
                    // 壁まで行ったらbreak
                    if(OthelloInital.wallEdge.contains(OthelloLogic.searchIndex)){
                        break
                    }
                    OthelloLogic.searchIndex = OthelloLogic.searchIndex + OthelloLogic.searchOthello(direction: direction)
                }
            }
            return OthelloLogic.directionArray
        }
        return []
    }
    
    // その方角に先攻のマスがある
    func is_there_a_first_strikes_trout_in_that_direction(direction: Azimuth, current: Int){
        if(OthelloData.secondArray.contains(OthelloLogic.searchIndex)){
            var loop = current
            // その直線状を自分の陣地があるまで探索
            while(true) {
                loop = loop + OthelloLogic.searchOthello(direction: direction)
                // 自分の陣地がある
                if OthelloData.firstArray.contains(loop) {
                    OthelloLogic.directionArray.append(direction)
                    foundEnemy = false
                    notFoundMe = false
                    break
                }
                // 端まで行ったらbreak
                if (OthelloInital.wallEdge.contains(loop)){
                    notFoundMe = false
                    break
                }
            }
        }
    }

    // その方角に後攻のマスがある
    func is_there_a_second_strikes_trout_in_that_direction(direction: Azimuth, current: Int){
        if(OthelloData.firstArray.contains(OthelloLogic.searchIndex)){
            var loop = current
            // その直線状を調べる
            while(true) {
                loop = loop + OthelloLogic.searchOthello(direction: direction)
                // 自分の陣地がある
                if OthelloData.secondArray.contains(loop) {
                    OthelloLogic.directionArray.append(direction)
                    foundEnemy = false
                    notFoundMe = false
                    break
                }
                // 端まで行ったらbreak
                if (OthelloInital.wallEdge.contains(loop)){
                    notFoundMe = false
                    break
                }
            }
        }
    }

    /// オセロ配置
    /// 00 |  01 02 03 04 05 06 07 08 |  09
    /// ---------------------------------
    /// 10 |  11 12 13 14 15 16 17 18 |  19
    /// 20 |  21 22 23 24 25 26 27 28 |  29
    /// 30 |  31 32 33 34 35 36 37 38 |  39
    /// 40 |  41 42 43 44 45 46 47 48 |  49
    /// 50 |  51 52 53 54 55 56 57 58 |  59
    /// 60 |  61 62 63 64 65 66 67 68 |  69
    /// 70 |  71 72 73 74 75 76 77 78 |  79
    /// 80 |  81 82 83 84 85 86 87 88 |  89
    /// ---------------------------------
    /// 90 |  91 92 93 94 95 96 97 98 |  99
    // 1マス隣の方位から差分を返す
    static func searchOthello(direction: Azimuth) -> Int{
        switch direction {
            case .WEST:
                return -1
            case .NORTHWEST:
                return -11
            case .NORTH:
                return -10
            case .NORTHEAST:
                return -9
            case .SOUTHWEST:
                return +9
            case .SOUTH:
                return +10
            case .SOUTHEAST:
                return +11
            case .EAST:
                return +1
        }
    }
}

//
//  OthelloBoardDelegate.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/02.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

/**
 *盤面をタッチされた時のイベントを受信するクラス
 */

class OthelloBoardDelegate: NSObject, UICollectionViewDelegate {
    weak var homeView: HomeViewController?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    /// Cellが選択された時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// TODO:ここをオセロの先攻後攻で白黒切り替えるようにする
        
        var currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        /// 上下左右左上右上左下右下で挟めるのか？8回検索(func allocable())
        let azimuths = OthelloLogic.allocable(cell:currentCell, current: indexPath.row)
        /// 隣に相手のオセロがある
        if(azimuths.count != 0){
            // 全方向検索
            for direction in azimuths {
                // 現在のオセロの位置
                var searchIndex = indexPath.row
                // 壁まで検索
                while(true){
                    searchIndex = searchIndex + OthelloLogic.searchOthello(direction: direction)
                    //その方向に先攻の人の陣地がある
                    if(OthelloData.isFirst){
                        //その方向に自分の陣地がある
                        if(OthelloData.firstArray.contains(searchIndex)){
                            var loop = indexPath.row
                            // その方向すべてを自分の陣地にする
                            while(loop != searchIndex) {
                                // 色反転
                                currentCell = collectionView.cellForItem(at: IndexPath.init(row: loop, section: 0)) as! CollectionViewCell
                                currentCell.highlightView.backgroundColor = .black
                                // 自分の陣地更新
                                if !OthelloData.firstArray.contains(loop) {
                                    OthelloData.firstArray.append(loop)
                                }
                                // 他人陣地を更新
                                if OthelloData.secondArray.contains(loop) {
                                    OthelloData.secondArray.remove(at: OthelloData.secondArray.firstIndex(of: loop)!)
                                }
                                loop = loop + OthelloLogic.searchOthello(direction: direction)
                            }
                            // 自分の陣地更新
                            if !OthelloData.firstArray.contains(loop) {
                                OthelloData.firstArray.append(loop)
                            }
                            // 他人陣地を更新
                            if OthelloData.secondArray.contains(loop) {
                                OthelloData.secondArray.remove(at: OthelloData.secondArray.firstIndex(of: loop)!)
                            }
                            break
                        }
                    } else {
                        //その方向に後攻の人の陣地がある
                        if(OthelloData.secondArray.contains(searchIndex)){
                            var loop = indexPath.row
                            // その方向すべてを自分の陣地にする
                            while(loop != searchIndex) {
                                // 色反転
                                currentCell = collectionView.cellForItem(at: IndexPath.init(row: loop, section: 0)) as! CollectionViewCell
                                currentCell.highlightView.backgroundColor = .white
                                // 自分の陣地更新
                                if !OthelloData.secondArray.contains(loop) {
                                    OthelloData.secondArray.append(loop)
                                }
                                // 他人陣地を更新
                                if OthelloData.firstArray.contains(loop) {
                                    OthelloData.firstArray.remove(at: OthelloData.firstArray.firstIndex(of: loop)!)
                                }
                                loop = loop + OthelloLogic.searchOthello(direction: direction)
                            }
                            // 自分の陣地更新
                            if !OthelloData.secondArray.contains(loop) {
                                OthelloData.secondArray.append(loop)
                            }
                            // 他人陣地を更新
                            if OthelloData.firstArray.contains(loop) {
                                OthelloData.firstArray.remove(at: OthelloData.firstArray.firstIndex(of: loop)!)
                            }
                            break
                        }
                    }
                    print("searchIndex: \(searchIndex)")
                    // 壁まで行ったらbreak
                    if(OthelloInital.wallEdge.contains(searchIndex)){
                        break
                    } else if (searchIndex < 0 || searchIndex > 99){
                        break
                    }
                }
            }
            //　先攻後攻を交代
            OthelloData.reverseTurn()
            homeView?.initiative.text = OthelloData.isFirst ? "先攻" : "後攻"
        }
    }

    /// Cellの選択が解除された時
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        debugLog(self)
        print("Deselected: \(indexPath)")
    }
}

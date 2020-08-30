//
//  OthelloBoardDelegate.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/02.
//  Copyright © 2020 susu. All rights reserved.
//

import UIKit
import SVGKit

/**
 *盤面をタッチされた時のイベントを受信するクラス
 */
class OthelloBoardDelegate: NSObject, UICollectionViewDelegate {
    weak var homeView: HomeViewController!
    
    var currentCell: CollectionViewCell!
    
    var logic = OthelloLogic.init()
    
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
        currentCell = (collectionView.cellForItem(at: indexPath) as! CollectionViewCell)
        /// 挟めるのか？8回検索
        let azimuths = logic.allocable(cell:currentCell, current: indexPath.row)
        /// 隣に相手のオセロがある
        if(azimuths.count != 0){
            // 置ける方向分検索
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
                            // その方向すべてを自分の陣地にする
                            makeThatDirectionAllFirstStrikesTerritory(
                                collectionView: collectionView,
                                direction: direction,
                                currentPath: indexPath.row,
                                searchIndex: searchIndex
                            )
                            break
                        }
                    } else {
                        //その方向に後攻の人の陣地がある
                        if(OthelloData.secondArray.contains(searchIndex)){
                            // その方向すべてを自分の陣地にする
                            makeThatDirectionAllSecondStrikesTerritory(
                                collectionView: collectionView,
                                direction: direction,
                                currentPath: indexPath.row,
                                searchIndex: searchIndex
                            )
                            break
                        }
                    }
                    // 壁まで行ったらbreak
                    if(OthelloInital.wallEdge.contains(searchIndex)){
                        break
                    }
                }
            }
            
            /** 先攻後攻を交代 **/
            OthelloData.reverse()
            let arrow = OthelloData.isFirst ? "right_arrow" : "left_arrow"
            guard let svgImage = SVGKImage(named: arrow) else {
                return
            }
            svgImage.size = homeView.initiative.frame.size
            homeView?.initiative.image = svgImage.uiImage

            // 点数表示
            homeView.firstPoint.text = String(format: "%02d", OthelloData.firstArray.count)
            homeView.secondPoint.text = String(format: "%02d", OthelloData.secondArray.count)

            /// 探索可能領域をグレーに
            if(logic.battlableAreaDisplay(collectionView: collectionView)){
                if(OthelloData.firstArray.count == 0){
                    alert(title: "後攻の人の勝ち！", message: "ゲームリセットしますか？", actions: GameActions.RESET)
                } else if (OthelloData.secondArray.count == 0){
                    alert(title: "先攻の人の勝ち！", message: "ゲームリセットしますか？", actions: GameActions.RESET)
                } else if(OthelloData.firstArray.count + OthelloData.secondArray.count == 64){
                    if(OthelloData.firstArray.count > OthelloData.secondArray.count){
                        alert(title: "先攻の人の勝ち！", message: "ゲームリセットしますか？", actions: GameActions.RESET)
                    } else {
                        alert(title: "後攻の人の勝ち！", message: "ゲームリセットしますか？", actions: GameActions.RESET)
                    }
                } else {
                    alert(title: "オセロが置けません", message: "パスしますか？", actions: GameActions.PASS)
                }
            }
        }
    }

    /// その方向をすべて先攻の領土にする
    func makeThatDirectionAllFirstStrikesTerritory(collectionView: UICollectionView, direction: Azimuth, currentPath: Int, searchIndex: Int) {
        var loop = currentPath
        while(loop != searchIndex) {
            // 色反転
            currentCell = (collectionView.cellForItem(at: IndexPath.init(row: loop, section: 0)) as! CollectionViewCell)
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
    }

    /// その方向をすべて後攻攻撃の領土にする
    func makeThatDirectionAllSecondStrikesTerritory(collectionView: UICollectionView, direction: Azimuth, currentPath: Int, searchIndex: Int) {
        var loop = currentPath
        while(loop != searchIndex) {
            // 色反転
            currentCell = (collectionView.cellForItem(at: IndexPath.init(row: loop, section: 0)) as! CollectionViewCell)
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
    }
    
    /// アラート表示
    func alert(title: String, message: String, actions: GameActions){
        let alertController: UIAlertController =
                    UIAlertController(title: title,
                              message: message,
                              preferredStyle: .alert)
         
        // OK のaction
        let defaultAction:UIAlertAction =
                    UIAlertAction(title: "OK",
                          style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                                switch actions {
                                    case .RESET:
                                        // ゲームリセット
                                        self.logic.gameReset(homeView: self.homeView)
                                        break
                                    case .PASS:
                                        // 強制的に交代
                                        self.logic.reverseTurn(homeView: self.homeView)
                                        break
                                }
                          })
        alertController.addAction(defaultAction)
        // UIAlertControllerの起動
        homeView.present(alertController, animated: true, completion: nil)
    }

    /// Cellの選択が解除された時
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        debugLog(self)
        print("Deselected: \(indexPath)")
    }
}

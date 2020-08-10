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
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        // デフォルトではtrue
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        // デフォルトではtrue
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Highlighted: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Unhighlighted: \(indexPath)")
    }
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

    /// Cellが選択された時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// TODO:ここをオセロの先攻後攻で白黒切り替えるようにする
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Selected: \(indexPath)")
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell

        /// 先攻である場合
        /// ひっくり返せるセルなのか検索
        ///   + 上下左右左上右上左下右下ですでにオセロが置いてあるのか検索
        ///     + 挟めるのか？8回検索(func allocable())
        let azimuth = OthelloLogic.allocable(cell:currentCell, current: indexPath.row)
        if(azimuth.count != 0){
            print("azimuth : \(azimuth[0])")
            currentCell.highlightView.backgroundColor = .black
        }
        ///       + ひっくり返せるのであれば、方位に従っておく(Azimuth)
        ///       + ひっくり返す(black/white)
        ///   + 何も無かったらそのまま
        ///
        /// 後攻である場合
        /// 上記先攻である場合の処理と同じ
    }

    /// Cellの選択が解除された時
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Deselected: \(indexPath)")
    }
}

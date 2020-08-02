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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Selected: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        debugLog(self)
        debugPrint("indexPath : \(indexPath)")
        print("Deselected: \(indexPath)")
    }
}

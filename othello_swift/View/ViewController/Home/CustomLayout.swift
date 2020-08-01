//
//  CustomLayout.swift
//  othello_swift
//
//  Created by Kazuki on 2020/07/27.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

/**
 オセロを敷くためのレイアウト構成クラス
 以下を参考にしている
 https://qiita.com/takehilo/items/d49069572c848df9258a
 */
class CustomLayout: UICollectionViewLayout {
    weak var delegate: CustomDelegate!
    var numColumns = 8
    var padding: CGFloat = 3
    var attributesArray = [UICollectionViewLayoutAttributes]()
    // 縦横の長さ
    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }

    // 1マスの大きさ設定
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    // セルの配置座標計算
    override func prepare() {
        guard attributesArray.isEmpty, let collectionView = collectionView else { return }

        let columnWidth = contentWidth / CGFloat(numColumns)
        var xOffsets = [CGFloat]()
        for column in 0..<numColumns {
            xOffsets.append(columnWidth * CGFloat(column))
        }

        var column = 0
        var yOffsets = [CGFloat](repeating: 0, count: numColumns)

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemHeight = delegate.collectionView(collectionView, heightForItemAt: indexPath)
            let height = itemHeight + padding * 2
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: padding, dy: padding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributesArray.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + height

            column = column < (numColumns - 1) ? (column + 1) : 0
        }
    }

    // 表示する要素のリスト
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in attributesArray {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
}

//extension CustomLayout: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        // デフォルトではtrue
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        // デフォルトではtrue
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        print("Highlighted: \(indexPath)")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        print("Unhighlighted: \(indexPath)")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        print("Selected: \(indexPath)")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        debugLog(self)
//        debugPrint("indexPath : \(indexPath)")
//        print("Deselected: \(indexPath)")
//    }
//}

//　CollectionViewLayoutに対して、大きさを外部から注入するためのprotocol
protocol CustomDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

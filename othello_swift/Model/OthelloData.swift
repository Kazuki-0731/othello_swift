//
//  OthelloData.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/01.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

class OthelloData {
    /// リセット用配列
    static var initArray:[IndexPath] = [IndexPath]()
    ///Bool 先手後手の判断
    static var isFirst = true
    ///array 先手配列
    static var firstArray = [Int]()
    ///array 後手配列
    static var secondArray = [Int]()
    /// 選択可能配列
    static var selectable = [Int]()
    ///int ターン数
    ///time タイマー
    ///int 点数の重さ
    ///Bool ゲーム開始フラグ
    var isStart : Bool = true

    static func reverse(){
        OthelloData.isFirst = !OthelloData.isFirst
    }
    
    static let shared = OthelloData()
    private init() {
        for loop in 0..<100{
            OthelloData.initArray.append(IndexPath(row: loop, section: 0))
        }
    }
}

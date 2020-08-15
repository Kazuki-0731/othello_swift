//
//  OthelloData.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/01.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

class OthelloData {
    ///Bool 先手後手の判断
    static var isFirst = true
    ///array 先手配列
    static var firstArray = [Int]()
    ///array 後手配列
    static var secondArray = [Int]()
    ///int ターン数
    ///time タイマー
    ///int 点数の重さ
    ///Bool ゲーム開始フラグ
    var isStart : Bool = true
    
    static func reverseTurn(){
        OthelloData.isFirst = !OthelloData.isFirst
    }
    
    static let shared = OthelloData()
    private init() {
    }
}

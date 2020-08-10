//
//  OthelloData.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/01.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

final public class OthelloData {
    ///int 現在選択されている状態
    ///array 先手配列
    var firstArray = OthelloInital.init().blackArrangement
    ///array 後手配列
    var secondArray = OthelloInital.init().whiteArrangement
    ///int ターン数
    ///time タイマー
    ///int 点数の重さ
    ///boolean ゲーム開始フラグ
    var isStart : Bool = true
    
    static let shared = OthelloData()
    private init() {
    }
}

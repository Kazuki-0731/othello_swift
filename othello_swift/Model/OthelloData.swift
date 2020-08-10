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
    ///array 後手配列
    ///int ターン数
    ///time タイマー
    ///int 点数の重さ
    ///boolean ゲーム開始フラグ
    var isStart : Bool = true
    
    static let sharedOthelloData = OthelloData()
    private init() {
    }
}

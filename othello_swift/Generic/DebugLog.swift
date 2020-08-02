//
//  DebugLog.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/01.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

/// ログ出力
func debugLog(_ obj: Any?,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
        if let obj = obj {
            print("[Function:\(function) Line:\(line)] : \(obj)")
        } else {
            print("[Function:\(function) Line:\(line)]")
        }
    #endif
}


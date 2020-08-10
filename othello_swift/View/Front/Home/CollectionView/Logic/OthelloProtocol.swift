//
//  OthelloLogicProtocol.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

protocol OthelloProtocol {
    static func allocable(cell:CollectionViewCell, current: Int) -> [Azimuth]
}

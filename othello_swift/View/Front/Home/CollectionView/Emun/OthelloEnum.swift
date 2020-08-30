//
//  OthelloEnum.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/10.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation

enum Azimuth : CaseIterable{
    case NORTHWEST
    case NORTH
    case NORTHEAST
    case WEST
    case EAST
    case SOUTHWEST
    case SOUTH
    case SOUTHEAST
}

enum GameActions {
    case RESET
    case PASS
}

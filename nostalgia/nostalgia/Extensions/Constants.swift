//
//  Constants.swift
//  nostalgia
//
//  Created by José Henrique Fernandes Silva on 31/05/21.
//

import Foundation

enum BitMaskCategories: UInt32 {
    case Player = 1
    case Shape = 2
    case Projectile = 4
}

enum TurnPlayer: Int {
    case up = 0
    case down = 1
    case right = 2
    case left = 3
    case rightUp = 4
    case rightDown = 5
    case leftUp = 6
    case leftDown = 7
}

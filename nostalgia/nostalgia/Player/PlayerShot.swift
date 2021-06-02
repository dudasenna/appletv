//
//  PlayerShot.swift
//  nostalgia
//
//  Created by Evaldo Garcia de Souza Júnior on 01/06/21.
//

import Foundation
import SpriteKit

enum Categories: UInt32 {
    case Player = 1
    case PlayerProjectile = 2
    case Enemy = 4
    case EnemyProjectile = 8
    case StrengthPowerUp = 16
    case SlowMotionPowerUp = 32
}

class PlayerProjectile: Projectile {
    let superShot: Bool
    
    init(player: Player, size: CGSize = CGSize(width: 80, height: 30), superShot: Bool = false) {
        self.superShot = superShot
        
        super.init(node: player, size: size, velocity: 275)
        
        physicsBody?.categoryBitMask = Categories.PlayerProjectile.rawValue
        physicsBody?.contactTestBitMask = Categories.Enemy.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

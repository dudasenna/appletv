//
//  Player.swift
//  nostalgia
//
//  Created by José Henrique Fernandes Silva on 31/05/21.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    init(width: CGFloat, height: CGFloat) {
        let texture = SKTexture(imageNamed: "Player")
        var size = CGSize()
        size.width = (103 + width + height) * 0.03
        size.height = (133 + width + height) * 0.03
        
        super.init(texture: texture, color: .white, size: size)
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.categoryBitMask = BitMaskCategories.Player.rawValue
        physicsBody?.collisionBitMask = BitMaskCategories.Player.rawValue
        physicsBody?.contactTestBitMask = BitMaskCategories.Form.rawValue
        physicsBody?.affectedByGravity = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotarionPlayer(turn: TurnPlayer, point: CGPoint) {
        var angle = CGFloat()
        switch turn {
        case TurnPlayer.up:
            angle = CGFloat.pi
        case TurnPlayer.down:
            angle = 0
        case TurnPlayer.right:
            angle = CGFloat.pi / 2
        case TurnPlayer.left:
            angle = -(CGFloat.pi / 2)
        case TurnPlayer.rightUp:
            angle = CGFloat.pi / 4
        case TurnPlayer.rightDown:
            angle = 7 * CGFloat.pi / 4
        case TurnPlayer.leftUp:
            angle = 3 * CGFloat.pi / 4
        case TurnPlayer.leftDown:
            angle = 5 * CGFloat.pi / 4
        default:
            print("Não entrou no switch em rotationPlayer")
        }
        
        let rotate = SKAction.rotate(toAngle: angle, duration: 0.15, shortestUnitArc: true)
        run(rotate)
        
        position = CGPoint(x: point.x, y: point.y)
    }
    
}

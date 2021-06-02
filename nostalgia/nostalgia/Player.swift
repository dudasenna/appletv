//
//  Player.swift
//  nostalgia
//
//  Created by José Henrique Fernandes Silva on 31/05/21.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    private var lastPosition = CGPoint(x: 0, y: 0)
    
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
    
    func rotate(point: CGPoint) {
        let relativeToStart = CGPoint(x: point.x - position.x, y: point.y - position.y)
        let radians = atan2(relativeToStart.y, relativeToStart.x)
        let rotateAction = SKAction.rotate(toAngle: radians, duration: 0.1, shortestUnitArc: true)
        run(rotateAction)
    }
    
    func movePlayer(to pos: CGPoint) {
        let newPosition = CGPoint(x: lastPosition.x + pos.x, y: lastPosition.y + pos.y)
        let move = SKAction.move(to: newPosition, duration: 0.3)
        run(move)
    }
    
    func saveLastPosition() {
        lastPosition = position
    }
    
}

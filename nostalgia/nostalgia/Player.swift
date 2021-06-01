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
    
    func playerRotation(to pos: CGPoint) {
        let turn = getTurn(position: pos)
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
        }
        
        let rotate = SKAction.rotate(toAngle: angle, duration: 0, shortestUnitArc: true)
        run(rotate)
    }
    
    func getTurn(position: CGPoint) -> TurnPlayer {
        let xDifference = 2 * self.lastPosition.x - position.x
        let yDifference = 2 * self.lastPosition.y - position.y
        
        var turn : TurnPlayer = TurnPlayer.up
        
        if xDifference == lastPosition.x && yDifference > lastPosition.y {
            turn = TurnPlayer.down
        }
        else if xDifference == lastPosition.x && yDifference < lastPosition.y {
            turn = TurnPlayer.up
        }
        else if xDifference > lastPosition.x && yDifference == lastPosition.y {
            turn = TurnPlayer.left
        }
        else if xDifference < lastPosition.x && yDifference == lastPosition.y {
            turn = TurnPlayer.right
        }
        else if xDifference > lastPosition.x && yDifference > lastPosition.y {
            turn = TurnPlayer.rightUp
        }
        else if xDifference > lastPosition.x && yDifference < lastPosition.y {
            turn = TurnPlayer.rightDown
        }
        else if xDifference < lastPosition.x && yDifference < lastPosition.y {
            turn = TurnPlayer.leftDown
        }
        else if xDifference < lastPosition.x && yDifference > lastPosition.y {
            turn = TurnPlayer.leftUp
        }
        
        return turn
    }
    
    func movePlayer(to pos: CGPoint) {
        let newPosition = mergePoints(point: lastPosition, point: pos)
        let move = SKAction.move(to: newPosition, duration: 0.5)
        run(move)
    }
    
    func mergePoints(point p1: CGPoint, point p2: CGPoint) -> CGPoint {
        let point = CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
        return point
    }
    
    func saveLastPosition() {
        lastPosition = position
    }
    
}

//
//  Player.swift
//  nostalgia
//
//  Created by Evaldo Garcia de Souza Júnior on 01/06/21.
//

import Foundation
import SpriteKit
import AVFoundation
import SwiftUI

class Player: SKSpriteNode {
    
    private var lastPosition = CGPoint(x: 0, y: 0)
    
    var lastTimeShot: TimeInterval
    let cooldown = 0.3
    
    var lastTimeSuperShot: TimeInterval
    let superCooldown = 10.0
    
    var superShotInterval: TimeInterval
    var superShotMinInterval = 1.0
    
    var stronger = false
    
    init(width: CGFloat, height: CGFloat) {
        lastTimeShot = cooldown
        lastTimeSuperShot = superCooldown
        superShotInterval = 0.0
        
        let currentTextureColor = GameScene.setTexture()
        let texture = SKTexture(imageNamed: "\(currentTextureColor[0])Player")
        var size = CGSize()
        let percentage = height * 0.1
        size.width = 133 * (percentage / 100)
        size.height = 103 * (percentage / 100)
        
        super.init(texture: texture, color: .white, size: size)
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.categoryBitMask = BitMaskCategories.Player.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = BitMaskCategories.Shape.rawValue
        physicsBody?.affectedByGravity = false
        
    }
    
    func rotate(point: CGPoint) {
        let relativeToStart = CGPoint(x: point.x + lastPosition.x - position.x, y: point.y + lastPosition.y - position.y)
        let radians = atan2(relativeToStart.y, relativeToStart.x)
        let rotateAction = SKAction.rotate(toAngle: radians, duration: 0.1, shortestUnitArc: true)
        run(rotateAction)
    }
    
    func movePlayer(to pos: CGPoint, frame: CGRect) {
     
        if position.x < frame.maxX - 50 && position.x > frame.minX+50 && position.y < frame.maxY-50 && position.y > frame.minY+50 {
            let newPosition = CGPoint(x: lastPosition.x + pos.x, y: lastPosition.y + pos.y)
            var move = SKAction.move(to: newPosition, duration: 2.5)
            run(move)
        } else {
            removeAllActions()
            var x: CGFloat = position.x
            var y: CGFloat = position.y
            
            if position.x < 0 {
                x = x+1
            } else {
                x = x-1
            }
            
            if position.y < 0 {
                y = y+1
            } else {
                y = y-1
            }
            
            position =  CGPoint(x: x, y: y)
        }
    }
    
    func saveLastPosition() {
        lastPosition = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shoot() {
        regularShoot()
    }
    
    func regularShoot() {
        let gameScene = scene as! GameScene
        let projectile = PlayerProjectile(player: self)
        
        let currentTextureColor = GameScene.setTexture()
        self.texture = SKTexture(imageNamed: "\(currentTextureColor[1])Player")
        gameScene.addChild(projectile)
    }
    
}

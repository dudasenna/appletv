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
        physicsBody?.collisionBitMask = BitMaskCategories.Player.rawValue
        physicsBody?.contactTestBitMask = BitMaskCategories.Form.rawValue
        physicsBody?.affectedByGravity = false
        
    }
    
//    init(position: CGPoint, size: CGSize = CGSize(width: 100, height: 100)) {
//        lastTimeShot = cooldown
//        lastTimeSuperShot = superCooldown
//        superShotInterval = 0.0
//
//        let texture = SKTexture(imageNamed: "Assets/bitty-1.png")
//        super.init(texture: texture, color: .white, size: size)
//
//        self.position = position
//        physicsBody = SKPhysicsBody(rectangleOf: size)
//
//        physicsBody?.linearDamping = 15
//        physicsBody?.angularDamping = 10
//
//        zRotation = CGFloat.pi/2
//
//        physicsBody?.categoryBitMask = Categories.Player.rawValue
//        physicsBody?.collisionBitMask = 0
//        physicsBody?.contactTestBitMask = Categories.Enemy.rawValue
//
//        blink()
//    }
    
    func rotate(point: CGPoint) {
        let relativeToStart = CGPoint(x: point.x + lastPosition.x - position.x, y: point.y + lastPosition.y - position.y)
        let radians = atan2(relativeToStart.y, relativeToStart.x)
        let rotateAction = SKAction.rotate(toAngle: radians, duration: 0.1, shortestUnitArc: true)
        run(rotateAction)
    }
    
    func movePlayer(to pos: CGPoint) {
        let newPosition = CGPoint(x: lastPosition.x + pos.x, y: lastPosition.y + pos.y)
        let move = SKAction.move(to: newPosition, duration: 3.5)
        run(move)
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
        print("atirou more")
        let gameScene = scene as! GameScene
        let projectile = PlayerProjectile(player: self)
        
        let currentTextureColor = GameScene.setTexture()
        self.texture = SKTexture(imageNamed: "\(currentTextureColor[1])Player")
        gameScene.addChild(projectile)
    }
    
}

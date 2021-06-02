//
//  Shot.swift
//  nostalgia
//
//  Created by Evaldo Garcia de Souza Júnior on 01/06/21.
//

import Foundation
import SpriteKit
import CoreGraphics
import SwiftUI

class Projectile: SKSpriteNode {
    
    init(node: SKSpriteNode, size: CGSize, texture: SKTexture = SKTexture(), velocity: CGFloat, circleBody: Bool = false) {
        
        super.init(texture: SKTexture(imageNamed: "purpleShot"), color: .white, size: size)
        
        // adicionando a cor certa
        let currentTextureColor = GameScene.setTexture()
        self.texture = SKTexture(imageNamed: "\(currentTextureColor[0])Shot")
        
        let dx = CGFloat(cosf(Float(node.zRotation)))
        let dy = CGFloat(sinf(Float(node.zRotation)))
        
        let px = node.position.x
        let py = node.position.y
        
        let pw = node.size.width
        let ph = node.size.height
        
        position = CGPoint(x: px+(dx*(pw/2-size.width/2)), y: py+(dy*(ph/2-size.width/2)))
        zRotation = node.zRotation
        
        zPosition = -1
        
        speed = node.speed
        
        physicsBody = circleBody ? SKPhysicsBody(circleOfRadius: size.width/2) : SKPhysicsBody(rectangleOf: size)
        
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        
        let amplitude = velocity*speed
        physicsBody?.velocity = CGVector(dx: dx*amplitude, dy: dy*amplitude)
        
        physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

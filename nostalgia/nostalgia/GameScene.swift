//
//  GameScene.swift
//  nostalgia
//
//  Created by Eduarda Senna on 31/05/21.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public static var currentColor: [Color] = []
    var playerPoints: Int = 0
    var playerExtraLife: Int = 3
    var pause: Bool?
    
    var colors: [Color] = [.blueColor, .greenColor, .orangeColor, .pinkColor, .purpleColor, .redColor, .yellowColor]
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : Player?
    private var lastPosition : CGPoint = CGPoint()
    
    override func didMove(to view: SKView) {
        GameScene.currentColor.append(colors.randomElement()!)
        GameScene.currentColor.append(colors.randomElement()!)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self

        //add shape
        let shape1 = chooseShape(randomNumber: Int.random(in: 1 ... 6), multiplierIndex: Int.random(in: 0 ... 2))
        shape1.position = CGPoint(x: -200, y: 100)
        self.addChild(shape1)
        
        let shape2 = chooseShape(randomNumber: Int.random(in: 1 ... 6), multiplierIndex: Int.random(in: 0 ... 2))
        shape2.position = CGPoint(x: 0, y: 100)
        self.addChild(shape2)
        
        let shape3 = chooseShape(randomNumber: Int.random(in: 1 ... 6), multiplierIndex: Int.random(in: 0 ... 2))
        shape3.position = CGPoint(x: 200, y: 100)
        self.addChild(shape3)
        

        size = self.frame.size
        self.player = Player(width: size.width, height: size.height)
        addChild(player!)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shoot))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue), NSNumber(value: UIPress.PressType.select.rawValue)]
        view.addGestureRecognizer(tapRecognizer)

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodiesBitMasks = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let projectileShapeBitMasks = BitMaskCategories.Projectile.rawValue | BitMaskCategories.Shape.rawValue
        let playerShapeBitMasks = BitMaskCategories.Player.rawValue | BitMaskCategories.Shape.rawValue
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if nodeA == nil || nodeB == nil {
            return
        }
        
        switch bodiesBitMasks {
        case projectileShapeBitMasks:
            // nodeA == projectile
            // nodeB == shape
            nodeA!.removeFromParent()
            nodeB!.removeFromParent()
        case playerShapeBitMasks:
            // nodeA == shape
            // nodeB == player
            nodeA!.removeFromParent()
        default:
            print("Entrou no default")
        }
    }
    
    func changeCurrentColor() {
        GameScene.currentColor.append(colors.randomElement()!)
        GameScene.currentColor.removeFirst()
        
    }
    
    @objc func shoot() {
        player?.regularShoot()
        changeCurrentColor()
    }
    
    public static func setTexture() -> [String] {
        let color = GameScene.currentColor
        var currentTexture: [String] = []
        
        for cor in color {
            if cor == .blueColor {
                currentTexture.append("blue")
            } else if cor == .greenColor {
                currentTexture.append("green")
            } else if cor == .orangeColor {
                currentTexture.append("orange")
            } else if cor == .pinkColor {
                currentTexture.append("pink")
            } else if cor == .purpleColor {
                currentTexture.append("purple")
            } else if cor == .redColor {
                currentTexture.append("red")
            } else {
                currentTexture.append("yellow")
            }
        }
    
        return currentTexture
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.greenColor
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.cyan
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.white
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            self.player?.movePlayer(to: t.location(in: self))
            self.player?.rotate(point: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
            player?.saveLastPosition()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            if item.type == .playPause {
                player?.regularShoot()
                self.view!.backgroundColor = UIColor.greenColor
            }
        }
    }
     
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            if item.type == .playPause {
                player?.regularShoot()
                self.view!.backgroundColor = UIColor.whiteColor
            }
        }
    }
     
    override func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // ignored
    }
     
    override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for item in presses {
            if item.type == .playPause {
                player?.regularShoot()
                self.view!.backgroundColor = UIColor.whiteColor
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

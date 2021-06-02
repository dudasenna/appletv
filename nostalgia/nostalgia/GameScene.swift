//
//  GameScene.swift
//  nostalgia
//
//  Created by Eduarda Senna on 31/05/21.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene {
    
    public static var currentColor: Color = .whiteColor
    var playerPoints: Int = 0
    var playerExtraLife: Int = 3
    var pause: Bool?
    
    var colors: [Color] = [.blueColor, .greenColor, .orangeColor, .pinkColor, .purpleColor, .redColor, .yellowColor]
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : Player?
    
    override func didMove(to view: SKView) {
        GameScene.currentColor = colors.randomElement()!
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: 100)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        player = Player(position: CGPoint(x: view.frame.midX-500, y: view.frame.midY-500))
        //size = self.frame.size
        //self.player = Player(width: size.width, height: size.height)
        addChild(player!)
        
    }
    
    func changeCurrentColor() {
        GameScene.currentColor = colors.randomElement()!
    }
    
    public static func setTexture() -> String {
        let color = GameScene.currentColor
        var currentTexture = ""
        if color == .blueColor {
            currentTexture = "blue"
        } else if color == .greenColor {
            currentTexture = "green"
        } else if color == .orangeColor {
            currentTexture = "orange"
        } else if color == .pinkColor {
            currentTexture = "pink"
        } else if color == .purpleColor {
            currentTexture = "purple"
        } else if color == .redColor {
            currentTexture = "red"
        } else if color == .yellowColor {
            currentTexture = "yellow"
        } else {
            // nothing here :)
        }
    
        return currentTexture
    }
    
    func touchDown(atPoint pos : CGPoint) {
        player?.regularShoot()
        changeCurrentColor()
        player?.turnLeft()
        //player?.dash()
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.greenColor
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.pinkColor
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //player?.regularShoot()
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.yellowColor
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
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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

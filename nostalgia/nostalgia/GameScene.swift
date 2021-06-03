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
    
    public static var currentColor: [Color] = []
    var playerPoints: Int = 0
    var playerExtraLife: Int = 3
    var pause: Bool?
    
    var colors: [Color] = [.blueColor, .greenColor, .orangeColor, .pinkColor, .purpleColor, .redColor, .yellowColor]
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : Player?
    private var lastPosition : CGPoint = CGPoint()
    var enimiesLimit = 10
    
//    var image = UIImage()
//    var image = drawCircle()
    
    override func didMove(to view: SKView) {
        GameScene.currentColor.append(colors.randomElement()!)
        GameScene.currentColor.append(colors.randomElement()!)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        
        //add shape
        
        createShape(current: 0)
        
//        let shape1 = chooseShape(randomNumber: Int.random(in: 1 ... 6), multiplierIndex: Int.random(in: 0 ... 2))
//        shape1.position = CGPoint(
//            x: randomCoordinate(max: 1000),
//            y: randomCoordinate(max: 800)
//        )
//
//        moveShape(shape: shape1)
//
//        self.addChild(shape1)
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
//        }

//        player1 = Player(position: CGPoint(x: view.frame.midX-500, y: view.frame.midY-500))
//        //size = self.frame.size
//        //self.player = Player(width: size.width, height: size.height)
//        addChild(player1!)

        size = self.frame.size
        self.player = Player(width: size.width, height: size.height)
        addChild(player!)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shoot))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue), NSNumber(value: UIPress.PressType.select.rawValue)]
        view.addGestureRecognizer(tapRecognizer)

    }
    
    func createShape (current: Int) {
        if current <= enimiesLimit {
            let shape = chooseShape(randomNumber: Int.random(in: 1...6), multiplierIndex: Int.random(in: 0...2))
            shape.position = CGPoint(
                x: randomCoordinate(max: 1000),
                y: randomCoordinate(max: 800)
            )
            
            moveShape(shape: shape)
            
            self.addChild(shape)
            
            let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                self.createShape(current: current + 1)
            }
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
    
    public func randomCoordinate(max: CGFloat) -> CGFloat {
      return CGFloat.random(in: -max...max)
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
        
//        if color == .blueColor {
//            currentTexture = "blue"
//        } else if color == .greenColor {
//            currentTexture = "green"
//        } else if color == .orangeColor {
//            currentTexture = "orange"
//        } else if color == .pinkColor {
//            currentTexture = "pink"
//        } else if color == .purpleColor {
//            currentTexture = "purple"
//        } else if color == .redColor {
//            currentTexture = "red"
//        } else if color == .yellowColor {
//            currentTexture = "yellow"
//        } else {
//            // nothing here :)
//        }
    
        return currentTexture
    }
    
    func touchDown(atPoint pos : CGPoint) {
//        player?.regularShoot()
//        changeCurrentColor()
        
        //player?.turnLeft()
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
            n.strokeColor = SKColor.cyan
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //changeCurrentColor()
        
        //player?.regularShoot()
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

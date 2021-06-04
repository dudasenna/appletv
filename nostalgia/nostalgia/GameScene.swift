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
    var pause: Bool?
    
    var colors: [Color] = [.blueColor, .greenColor, .orangeColor, .pinkColor, .purpleColor, .redColor, .yellowColor]
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : Player?
    private var lastPosition : CGPoint = CGPoint()
    var enimiesLimit = 10
    
    var uiLeft: SKSpriteNode?
    var uiRight: SKSpriteNode?
    var pointsLabel: SKLabelNode?
    var playerPoints: Int = 0 {
        didSet {
            pointsLabel!.text = "\(playerPoints)"
        }
    }
    var extralifeLabel: SKLabelNode?
    var playerExtraLife: Int = 3 {
        didSet {
            extralifeLabel!.text = "\(playerExtraLife)x"
        }
        
    }
    
    override func didMove(to view: SKView) {
        // UI
        self.uiRight = SKSpriteNode.init(texture: SKTexture(imageNamed: "uiRight"), size: CGSize(width: 245, height: 79))
        self.uiRight?.position = CGPoint(x: frame.maxX-100, y: frame.maxY-100)
        //self.uiRight?.position = CGPoint(x: 0+size.width/2, y: frame.maxY-100)
        self.uiRight?.zPosition = -3
        addChild(uiRight!)
        
        self.uiLeft = SKSpriteNode.init(texture: SKTexture(imageNamed: "uiLeft"), size: CGSize(width: 245, height: 79))
        self.uiLeft?.position = CGPoint(x: frame.minX+100, y: frame.maxY-100)
        //self.uiLeft?.position = CGPoint(x: 0-size.width/2, y: frame.maxY-100)
        self.uiRight?.zPosition = -3
        addChild(uiLeft!)
        
        // game
        GameScene.currentColor.append(colors.randomElement()!)
        GameScene.currentColor.append(colors.randomElement()!)
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody?.categoryBitMask = BitMaskCategories.Wall.rawValue
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = BitMaskCategories.Player.rawValue | BitMaskCategories.Projectile.rawValue
        
        // add shape
        createShape(current: 0)
        
        // player
        size = self.frame.size
        self.player = Player(width: size.width, height: size.height)
        addChild(player!)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shoot))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue), NSNumber(value: UIPress.PressType.select.rawValue)]
        view.addGestureRecognizer(tapRecognizer)
        
        
        // score
        self.pointsLabel = SKLabelNode(fontNamed: "Bebas Neue")
        self.pointsLabel?.fontColor = .blackColor
        self.pointsLabel?.text = "\(playerPoints)"
        self.pointsLabel?.position = CGPoint(x: frame.maxX-130, y: frame.maxY-117)
        self.pointsLabel?.fontSize = 60
        self.pointsLabel?.zPosition = 3
        addChild(pointsLabel!)
        
        // extra life
        self.extralifeLabel = SKLabelNode(fontNamed: "Bebas Neue")
        self.extralifeLabel?.fontColor = .blackColor
        self.extralifeLabel?.text = "\(playerExtraLife)x"
        self.extralifeLabel?.position = CGPoint(x: frame.minX+120, y: frame.maxY-110)
        self.extralifeLabel?.fontSize = 40
        self.extralifeLabel?.zPosition = 3
        addChild(extralifeLabel!)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodiesBitMasks = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let projectileShapeBitMasks = BitMaskCategories.Projectile.rawValue | BitMaskCategories.Shape.rawValue
        let playerShapeBitMasks = BitMaskCategories.Player.rawValue | BitMaskCategories.Shape.rawValue
        let projectileWallBitMask = BitMaskCategories.Projectile.rawValue | BitMaskCategories.Wall.rawValue
        let playerWallBitMask = BitMaskCategories.Player.rawValue | BitMaskCategories.Wall.rawValue
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if nodeA == nil || nodeB == nil {
            return
        }
        
        switch bodiesBitMasks {
        case projectileShapeBitMasks:
            if nodeA!.name == nodeB!.name {
                nodeA!.removeFromParent()
                nodeB!.removeFromParent()
                playerPoints += 1
            }
            
        case playerShapeBitMasks:
            if playerExtraLife > 1 {
                playerExtraLife -= 1
            } else {
                // end game aqui
            }
            
            if nodeA?.frame == self.player!.frame {
                nodeB!.removeFromParent()
            } else {
                nodeA!.removeFromParent()
            }
            
        case projectileWallBitMask:
            let waitAction = SKAction.wait(forDuration: 2)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([waitAction, removeAction])
            nodeB!.run(sequenceAction)
        case playerWallBitMask:
            nodeB!.removeAllActions()
        default:
            print("Entrou no default")
        }
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
            self.player?.movePlayer(to: t.location(in: self), frame: frame)
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

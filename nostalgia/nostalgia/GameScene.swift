//
//  GameScene.swift
//  nostalgia
//
//  Created by Eduarda Senna on 31/05/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : Player?
    private var lastPosition : CGPoint = CGPoint()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        size = self.frame.size
        self.player = Player(width: size.width, height: size.height)
        addChild(player!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blackColor
            self.addChild(n)
        }
    }
    
    func movePlayer(toPoint pos: CGPoint) {
        let xDifference = 2 * self.lastPosition.x - pos.x
        let yDifference = 2 * self.lastPosition.y - pos.y
        
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
        
        self.player?.rotarionPlayer(turn: turn, point: pos)
            
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
            self.movePlayer(toPoint: t.location(in: self))
            self.lastPosition = t.location(in: self)
            
            
            // TODO: Lógica para movimentar o personagem
            //      Pegar o movimento ao invés da posição especifica
            //      Tomar cuidado com a posição inicial (zero?) do personagem, acho que um if resolve
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

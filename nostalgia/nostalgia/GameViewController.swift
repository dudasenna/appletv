//
//  GameViewController.swift
//  nostalgia
//
//  Created by Eduarda Senna on 31/05/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var observer: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name("teste"), object: nil, queue: OperationQueue.main) {_ in
            self.perdeu()
        }

    }
    
    func perdeu() {
        let message = "Sua pontuação: \(GameScene.points)"
        let alert = UIAlertController(title: "FIM DE JOGO", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }

}

//
//  GameViewController.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 20/05/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    static var currentView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            GameViewController.currentView = view
            
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
    }
    
    static func changeScene(to sceneName: String) {
        let transition = SKTransition.fade(withDuration: 0.25)
        let scene = SKScene(fileNamed: sceneName)!
        scene.size = currentView.scene!.size
        
        if let gameOverScene = scene as? GameOverScene,
           let gameScene = currentView.scene as? GameScene {
            gameOverScene.score = gameScene.score
            
            if let highScore = UserDefaults.standard.integer(forKey: "highScore") as Int?,
               gameScene.score > highScore {
                UserDefaults.standard.set(gameScene.score, forKey: "highScore")
            }
        }
        
        currentView.presentScene(scene, transition: transition)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

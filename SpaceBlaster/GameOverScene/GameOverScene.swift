//
//  GameOverScene.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 21/05/23.
//

import SpriteKit

class GameOverScene: SKScene {
    var score: Int = 0
    
    var starField: SKEmitterNode!
    var scoreText: SKLabelNode!
    var highScoreText: SKLabelNode!
    var restartBtn: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        starField = self.scene?.childNode(withName: "Starfield") as? SKEmitterNode
        starField.advanceSimulationTime(5)
        
        scoreText = self.scene?.childNode(withName: "ScoreText") as? SKLabelNode
        scoreText.text = "Score: \(score)"
                
        highScoreText = self.scene?.childNode(withName: "HighScoreText") as? SKLabelNode
        if let highScore = UserDefaults.standard.integer(forKey: "highScore") as Int? {
            highScoreText.text = "High Score: \(highScore)"
        }
        
        restartBtn = self.scene?.childNode(withName: "RestartBtn") as? SKSpriteNode
        
        SoundManager.shared.playSfx(scene: self, name: "explodeSfx", volume: 0.5, destroyAfter: 2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "RestartBtn" {
                let transition = SKTransition.fade(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene.sks")!
                gameScene.size = self.size
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}

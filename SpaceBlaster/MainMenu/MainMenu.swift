//
//  MainMenu.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 26/05/23.
//

import SpriteKit

class MainMenu: SKScene {
    var starField: SKEmitterNode!
    var highScoreText: SKLabelNode!
    var playBtn: SKSpriteNode!
    var background: Background!
    
    override func didMove(to view: SKView) {
        starField = childNode(withName: "Starfield") as? SKEmitterNode
        highScoreText = childNode(withName: "HighScoreText") as? SKLabelNode
        playBtn = childNode(withName: "PlayBtn") as? SKSpriteNode
        background = childNode(withName: "Background") as? Background
        
        starField.advanceSimulationTime(20)
        if let highScore = UserDefaults.standard.integer(forKey: "highScore") as Int? {
            highScoreText.text = "High Score: \(highScore)"
        }
        
        SoundManager.shared.playSfx(scene: self, name: "explodeSfx", volume: 0, destroyAfter: 2)
    }
    
    var timeOnLastFrame: TimeInterval?
    override func update(_ currentTime: TimeInterval) {
        var deltaTime = timeOnLastFrame != nil ? (currentTime - timeOnLastFrame!) : 0
        if deltaTime >= 1.0 { deltaTime = 0.02 }
        
        background.parallaxScroll(deltaTime: deltaTime)
        
        timeOnLastFrame = currentTime
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            if playBtn.contains(location) {
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene.sks")!
                gameScene.size = self.size
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}

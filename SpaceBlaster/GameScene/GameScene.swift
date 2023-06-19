//
//  GameScene.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 20/05/23.
//

import SpriteKit

class GameScene: SKScene {
    private var enemies = [Enemy]()
    
    //called once when the scene just started
    override func didMove(to view: SKView) {
        spawnEnemy()
    }
    
    //spawn an enemy every 1.2 seconds
    private func spawnEnemy() {
        let enemy = Enemy(imageNamed: "enemySprite", in: self)
        enemies.append(enemy)
        
        self.run(SKAction.wait(forDuration: 1.2)) {
            self.spawnEnemy()
        }
    }
    
    var timeOnLastFrame: TimeInterval = 0
    
    //called every frame
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = calculateDeltaTime(from: currentTime)
        
        for enemy in enemies {
            enemy.moveDownwards(deltaTime: deltaTime)
            
            if enemy.destroyed {
                enemies.removeAll(where: { $0 == enemy })
            }
        }
    }
    
    //calculate the time difference between the current and previous frame
    private func calculateDeltaTime(from currentTime: TimeInterval) -> TimeInterval {
        if timeOnLastFrame.isZero { timeOnLastFrame = currentTime }
        let deltaTime = currentTime - timeOnLastFrame
        timeOnLastFrame = currentTime
        return deltaTime
    }
}

//
//  Enemy.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 21/05/23.
//

import SpriteKit
import GameplayKit

extension GameScene {
    @objc func spawnEnemy() {
        enemyNamesList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemyNamesList) as! [String]
        
        let enemy = Enemy(imageNamed: enemyNamesList[0])
        
        let randomXPos = Double.random(in: (-screenWidth/2 + enemy.size.width) ... (screenWidth/2  - enemy.size.width))
        let yPos = screenHeight/2 + enemy.size.height
        enemy.position = CGPoint(x: randomXPos, y: yPos)
        
        self.addChild(enemy)
        enemies.append(enemy)
        
        self.run(SKAction.wait(forDuration: enemySpawnInterval)) {
            if self.enemySpawnInterval > self.enemySpawnMinInterval {
                self.enemySpawnInterval -= self.enemySpawnDecrement
            }
            self.spawnEnemy()
        }
    }
}

//
//  GameSceneContactDelegate.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 21/05/23.
//

import SpriteKit

///Contact Delegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bit1 = contact.bodyA.categoryBitMask
        let bit2 = contact.bodyB.categoryBitMask
        
        if (bit1 == Bitmask.bullet && bit2 == Bitmask.enemy) ||
            (bit1 == Bitmask.enemy && bit2 == Bitmask.bullet) {
            let (bulletCollider, enemyCollider) = (bit1 == Bitmask.bullet) ?
                (contact.bodyA, contact.bodyB) : (contact.bodyB, contact.bodyA)
            
            if let bulletNode = bulletCollider.node as? SKSpriteNode,
               let enemyNode = enemyCollider.node as? Enemy {
                bulletTouchesEnemy(bullet: bulletNode, enemy: enemyNode)
            }
        }
        
        if (bit1 == Bitmask.player && bit2 == Bitmask.enemy) ||
            (bit1 == Bitmask.enemy && bit2 == Bitmask.player) {
            let (playerCollider, enemyCollider) = (bit1 == Bitmask.player) ?
                (contact.bodyA, contact.bodyB) : (contact.bodyB, contact.bodyA)
            
            if let playerNode = playerCollider.node as? Player,
                let enemyNode = enemyCollider.node as? Enemy {
                playerTouchesEnemy(player: playerNode, enemy: enemyNode)
            }
        }
    }
    
    func bulletTouchesEnemy(bullet: SKSpriteNode, enemy: Enemy) {
        bullet.removeFromParent()
        enemy.destroy()
        
        SoundManager.shared.playSfx(scene: self, name: "explodeSfx", volume: 0.5, destroyAfter: 2)
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = enemy.position
        self.addChild(explosion)
        self.run (SKAction.wait (forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 1
    }
    
    func playerTouchesEnemy(player: Player, enemy: Enemy) {
        player.removeFromParent()
        enemy.destroy()
        
        SoundManager.shared.playSfx(scene: self, name: "explodeSfx", volume: 0.5, destroyAfter: 2)
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = enemy.position
        self.addChild(explosion)
        self.run (SKAction.wait (forDuration: 0.5)) {
            GameViewController.changeScene(to: "GameOverScene.sks")
        }
    }
}

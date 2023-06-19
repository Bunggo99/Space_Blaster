//
//  Bullet.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 21/05/23.
//

import SpriteKit

extension GameScene {
//    func shootBullet() {
//        guard canShoot else { return }
//        
//        let bullet = SKSpriteNode(imageNamed: "bullet")
//        bullet.name = "bullet"
//        bullet.position = player.position
//        bullet.zPosition = -1
//        bullet.position.y += 5
//        
//        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
//        bullet.physicsBody?.isDynamic = true
//        
//        bullet.physicsBody?.categoryBitMask = Bitmask.bullet
//        bullet.physicsBody?.contactTestBitMask = Bitmask.enemy
//        bullet.physicsBody?.collisionBitMask = 0
//        bullet.physicsBody?.usesPreciseCollisionDetection = true
//        
//        self.addChild(bullet)
//        
//        var actionSequence = [SKAction]()
//        
//        let travelDuration: TimeInterval = 0.5
//        actionSequence.append(SKAction.move(to: CGPoint(x: bullet.position.x, y: screenHeight+10), duration: travelDuration))
//        actionSequence.append(SKAction.removeFromParent())
//        
//        bullet.run(SKAction.sequence(actionSequence))
//        
//        SoundManager.shared.playSfx(scene: self, name: "shootSfx", volume: 0.1, destroyAfter: 2)
//        
//        canShoot = false
//        self.run(SKAction.wait(forDuration: shootInterval)) {
//            self.canShoot = true
//        }
//    }
}

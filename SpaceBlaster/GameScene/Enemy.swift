//
//  Enemy.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 23/05/23.
//

import SpriteKit

class Enemy: SKSpriteNode {
    let spriteSize = (width: 84.2, height: 84.2)
    
    var moveSpeed = 400.0
    var rotateSpeed = 1.0
    var destroyed = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        name = "enemy"
        self.size = CGSize(width: spriteSize.width, height: spriteSize.height)
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2 - 5)
        physicsBody?.isDynamic = true
        physicsBody?.angularVelocity = rotateSpeed * (Bool.random() ? 1 : -1)
        
        physicsBody?.categoryBitMask = Bitmask.enemy
        physicsBody?.contactTestBitMask = Bitmask.player
        physicsBody?.collisionBitMask = 0
    }
    
    convenience init() {
        let texture = SKTexture(imageNamed: "Asteroid")
        self.init(texture: texture, color: .white, size: texture.size())
    }
    
    convenience init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        self.init(texture: texture, color: .white, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveDownwards(deltaTime: Double, minPosition: Double) {
        if destroyed { return }
        
        position.y -= (moveSpeed * deltaTime)
        
        if position.y <= minPosition - size.height {
            destroy()
            GameViewController.changeScene(to: "GameOverScene.sks")
        }
    }
    
    func destroy() {
        removeFromParent()
        destroyed = true
    }
}

//
//  Enemy.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 30/05/23.
//

import SpriteKit

class Enemy: SKSpriteNode {
    var screenHeight: Double { scene!.frame.size.height }
    var screenWidth: Double { scene!.frame.size.width }
    
    let enemyName = "enemy"
    let enemySize = (width: 84.2, height: 84.2)
    let moveSpeed = 400.0
    var destroyed = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    init(imageNamed name: String, in scene: SKScene) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .white, size: texture.size())
        scene.addChild(self)
        
        self.name = enemyName
        self.size = CGSize(width: enemySize.width, height: enemySize.height)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2 - 5)
        
        let maxXPos = screenWidth/2 - self.size.width
        let randomXPos = Double.random(in: -maxXPos...maxXPos)
        let yPos = screenHeight/2 + self.size.height
        self.position = CGPoint(x: randomXPos, y: yPos)
    }
    
    func moveDownwards(deltaTime: Double) {
        if destroyed { return }
        
        self.position.y -= (moveSpeed * deltaTime)
        if self.position.y <= (-screenHeight/2 - self.size.height) {
            destroy()
        }
    }
    
    func destroy() {
        destroyed = true
        removeFromParent()
    }
}

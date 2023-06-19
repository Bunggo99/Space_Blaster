//
//  Enemy.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 23/05/23.
//

import SpriteKit

class Enemy2: SKSpriteNode {
    var screenHeight: Double { scene!.frame.size.height }
    var screenWidth: Double { scene!.frame.size.width }
    
    let objectName = "enemy"
    let spriteSize = (width: 100.0, height: 100.0)
    let moveSpeed = 400.0
    var destroyed = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    init(imageNamed name: String, in scene: SKScene) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .white, size: texture.size())
        
        scene.addChild(self)
        
        self.name = objectName
        self.size = CGSize(width: spriteSize.width, height: spriteSize.height)
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

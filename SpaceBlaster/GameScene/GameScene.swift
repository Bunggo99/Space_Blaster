//
//  GameScene.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 20/05/23.
//

import SpriteKit
import CoreMotion

struct Bitmask {
    static let bullet: UInt32 = 0x1
    static let enemy: UInt32 = 0x2
    static let player: UInt32 = 0x4
}

class GameScene: SKScene {
    
    ///screen size
    var screenHeight: Double { self.frame.size.height }
    var screenWidth: Double { self.frame.size.width }
    
    ///score
    var scoreText: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreText.text = "Score: \(score)"
        }
    }
    
    var starField: SKEmitterNode!
    var background: Background!
    var headerText: SKLabelNode!
    
    ///player
    var player: Player!
    let playerDragRadius = 55.0
    var draggingTouch: UITouch?
    var canShoot = true
    var shootInterval = 0.3
    
    ///enemy
    var enemies = [Enemy]()
    var enemySpawnInterval = 1.2
    var enemySpawnMinInterval = 0.4
    var enemySpawnDecrement = 0.01
    
    var enemySpeed = 300.0
    var enemyMaxSpeed = 700.0
    var enemySpeedIncrement = 5.0
    
    let enemyTravelDuration: TimeInterval = 10
    var enemyNamesList = ["asteroid", "asteroid2", "asteroid3"]
    
    ///start function, once called once
    override func didMove(to view: SKView) {
        
        SoundManager.shared.playSfx(scene: self, name: "explodeSfx", volume: 0, destroyAfter: 2)
        
        ///set the contact delegate (contact callbacks) to ourself
        self.physicsWorld.contactDelegate = self
        
        ///get the particle emitter from the game scene
        starField = childNode(withName: "Starfield") as? SKEmitterNode
        ///start at 10 seconds of the simulation so that the stars/ will already fill the screen
        starField.advanceSimulationTime(5)
        
        background = childNode(withName: "Background") as? Background
        headerText = childNode(withName: "HeaderText") as? SKLabelNode
        scoreText = childNode(withName: "ScoreText") as? SKLabelNode
        player = childNode(withName: "Player") as? Player
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.isDynamic = true
        
        player.physicsBody?.categoryBitMask = Bitmask.player
        player.physicsBody?.contactTestBitMask = 0
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        background.scrollSpeed *= 64.0
        
        headerText.alpha = 0
        let fadeInAction = SKAction.fadeIn(withDuration: 1)
        let waitDuration = SKAction.wait(forDuration: 1)
        let fadeOutAction = SKAction.fadeOut(withDuration: 1)
        let sequenceAction = SKAction.sequence([fadeInAction, waitDuration, fadeOutAction])
        headerText.run(sequenceAction, completion: {
            self.background.scrollSpeed /= 64.0
            self.startSpawningEnemy()
        })
    }
    
    ///called every frame
    var timeOnLastFrame: TimeInterval?
    override func update(_ currentTime: TimeInterval) {
        var deltaTime = timeOnLastFrame != nil ? (currentTime - timeOnLastFrame!) : 0
        if deltaTime >= 1.0 { deltaTime = 0.02 }
        
        background.parallaxScroll(deltaTime: deltaTime)
        for enemy in enemies {
            enemy.moveDownwards(deltaTime: deltaTime, minPosition: -screenHeight/2)
            if enemy.destroyed {
                enemies.removeAll(where: { $0.destroyed == true })
            }
        }
        
        timeOnLastFrame = currentTime
    }
    
    ///fixed update, called every physics update
//    override func didSimulatePhysics() { }
    
    ///called every time the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        
//        let nodes = self.nodes(at: touchLocation)
//        for node in nodes {
//            if node.name == "ShootBtn" {
//                shootBullet()
//            }
//        }
        
        if touchLocation.distance(to: player.position) <= playerDragRadius  {
            draggingTouch = touch
        }
        else {
            shootBullet()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let touchLocation = firstTouch.location(in: self)
        
        if draggingTouch == nil && touchLocation.distance(to: player.position) <= playerDragRadius  {
            draggingTouch = firstTouch
        }
        if draggingTouch == firstTouch  {
            player.position = touchLocation
            
            player.position.x = max(player.position.x, -screenWidth/2.0 + (player.size.width/2.0))
            player.position.x = min(player.position.x, screenWidth/2.0 - (player.size.width/2.0))
            
            player.position.y = max(player.position.y, -screenHeight/2.0 + (player.size.height/2.0))
            player.position.y = min(player.position.y, screenHeight/2.0 - (player.size.height/2.0))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        if draggingTouch == firstTouch  {
            draggingTouch = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        
        if draggingTouch == firstTouch  {
            draggingTouch = nil
        }
    }
}

extension CGPoint {
    func distance(to p2: CGPoint) -> Double {
        let xDist = (p2.x - self.x)
        let yDist = (p2.y - self.y)
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}

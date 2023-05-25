//
//  File.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 21/05/23.
//

import SpriteKit

struct SoundManager {
    static let shared = SoundManager()
    
    private init() { }
    
    func playSfx(scene: SKScene, name: String, volume: Float, destroyAfter: Double) {
        //easy way to play sound, but you can't adjust it's volume
        //        let playSfxAction = SKAction.playSoundFileNamed("shootSfx", waitForCompletion: false)
        //        self.run(playSfxAction)
        
        let audioNode = SKAudioNode(fileNamed: name)
        audioNode.position = CGPoint(x: 0, y: 0)
        audioNode.autoplayLooped = false
        scene.addChild(audioNode)
        audioNode.run(SKAction.changeVolume(to: volume, duration: 0))
        audioNode.run(SKAction.play())
        
        scene.run(SKAction.wait(forDuration: destroyAfter)) {
            audioNode.removeFromParent()
        }
    }
}

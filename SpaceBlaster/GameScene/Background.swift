//
//  Background.swift
//  SpaceBlaster
//
//  Created by Ardli Fadhillah on 22/05/23.
//

import SpriteKit

class Background: SKSpriteNode {
    
    var scrollSpeed = 11.1
    
    func parallaxScroll(deltaTime: Double){
        position.y -= (scrollSpeed * deltaTime)
        
        if position.y <= -size.height * 3 {
            position.y = 0
        }
    }
    
}

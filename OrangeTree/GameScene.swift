//
//  GameScene.swift
//  OrangeTree
//
//  Created by Jamar Gibbs on 9/19/18.
//  Copyright © 2018 B3773R. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var orangeTree : SKSpriteNode!
    var orange: Orange?
    var touchStart : CGPoint = .zero
    var shapeNode = SKShapeNode()
    
    override func didMove(to view: SKView) {
        orangeTree = childNode(withName: "tree") as! SKSpriteNode
        
        // Configure shapeNode
        shapeNode.lineWidth = 20
        shapeNode.lineCap = .round
        shapeNode.strokeColor = UIColor(white: 1, alpha: 0.3)
        addChild(shapeNode)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get location of touch on the screen
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Check if the touch was on the Orange Tree
        if atPoint(location).name == "tree" {
            orange = Orange()
            orange?.physicsBody?.isDynamic = false
            orange?.position = location
            addChild(orange!)
            
        // Store the location of the touch
            touchStart = location
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?){
        let touch = touches.first!
        let location = touch.location(in: self)
        // Update position of the orange to the current location
        orange?.position = location

        // Draw the firing vector
        let path = UIBezierPath()
        path.move(to: touchStart)
        path.addLine(to: location)
        shapeNode.path = path.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of where the touch ended
        let touch = touches.first!
        let location = touch.location(in: self)

        // Get the difference between the start and endpoint as a vector
        let dx = touchStart.x - location.x
        let dy = touchStart.y - location.y
        let vector = CGVector(dx: dx, dy: dy)

        // Set the orange dynamic again and apply the vector as an impulse
        orange?.physicsBody?.isDynamic = true
        orange?.physicsBody?.applyImpulse(vector)

        shapeNode.path = nil
    }
}

extension GameScene : SKPhysicsContactDelegate {
    // Called when the physicsworld detects two nodes colliding
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
    
    // Check that the two bodies collided hard enough
        if contact.collisionImpulse > 15 {
            if nodeA?.name == "skull" {
                removeSkull(node: nodeA!)
            } else if nodeB?.name == "skull" {
                removeSkull(node: nodeB!)
            }
        }
    }
    
    // Function to remove the skull from the node scene
    func removeSkull(node: SKNode) {
        node.removeFromParent()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}











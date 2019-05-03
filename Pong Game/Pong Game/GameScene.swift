import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var ball: SKSpriteNode!
    var enemy: SKShapeNode!
    var main: SKShapeNode!
    
    var topLabel: SKLabelNode!
    var bottomLabel: SKLabelNode!
    
    var score = [Int]()
    
    
    override func didMove(to view: SKView) {
        
        
        topLabel = SKLabelNode(text: "0")
        topLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 100)
        addChild(topLabel)
        
        
        
        bottomLabel =  SKLabelNode(text: "0")
        bottomLabel.position = CGPoint(x: size.width/2, y: size.height/2 - 100)
        addChild(bottomLabel)
        
        
        ball = childNode(withName: "ball") as? SKSpriteNode
        
        let paddleSize = CGSize(width: 140, height: 10)
        
        enemy = SKShapeNode(rectOf: paddleSize)
        enemy.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 65)
        enemy.fillColor = .red
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.frame.size)
        enemy.physicsBody?.isDynamic = false
        addChild(enemy)
        
        
        main = SKShapeNode(rectOf: paddleSize)
        main.position = CGPoint(x: frame.size.width/2, y: 50)
        main.fillColor = .white
        main.physicsBody = SKPhysicsBody(rectangleOf: main.frame.size)
        main.physicsBody?.isDynamic = false
        addChild(main)
    
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        
        ball.physicsBody?.angularVelocity = self.physicsBody!.angularVelocity
        let ballDirection = physicsBody?.angularVelocity
        ball.physicsBody?.velocity = self.physicsBody!.velocity
        ball.physicsBody?.applyForce(_:at :asImpulse: true)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score [1]))"
        bottomLabel.text = "\(score [0]))"
    }
    
    func addScore(playerWhoWon : SKShapeNode){
        if playerWhoWon == main {
            score[0] += 1
        }
            
        else if playerWhoWon == enemy {
            score[1] += 1
}
        topLabel.text = "\(score [1])"
        bottomLabel.text = "\(score [0])"

        
//    ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
//    ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//
//            main.run(SKAction.moveTo(x: location.x, duration:0.2))
//        }
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.position = CGPoint(x: location.x, y: main.position.y)
            
            }
        }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
            
    enemy.run(SKAction.moveTo(x: ball.position.x , duration: 1.0))
    
            if ball.position.y <= main.position.y - 70 {
                addScore(playerWhoWon: enemy)
    }
            else if ball.position.y <= enemy.position.y + 70 {
                addScore(playerWhoWon: main )
            }
}
}


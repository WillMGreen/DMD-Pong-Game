import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {

    let ballCategory: UInt32 = 1;
    let rectCategory: UInt32 = 2;
    let frameCategory: UInt32 = 4;
    
    var ball: SKSpriteNode!
    var enemy: SKShapeNode!
    var main: SKShapeNode!
    var base: SKShapeNode!
    
    var topLabel: SKLabelNode!
    var bottomLabel: SKLabelNode!
    
    var playerScore = 0
    
    override func didMove(to view: SKView) {
        
        
        
        backgroundColor = .black
        topLabel = SKLabelNode(text: "0")
        topLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 100)
        addChild(topLabel)
        physicsWorld.contactDelegate = self
        
        bottomLabel =  SKLabelNode(text: "0")
        bottomLabel.position = CGPoint(x: size.width/2, y: size.height/2 - 100)
        addChild(bottomLabel)
        

        ball = SKSpriteNode(imageNamed: "Ball")
        ball.name = "ball"
        ball.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(ball)
        
        let paddleSize = CGSize(width: 140, height: 25)
        
        enemy = SKShapeNode(rectOf: paddleSize)
        enemy.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 40)
        enemy.fillColor = .red
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.frame.size)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.contactTestBitMask = rectCategory
        enemy.physicsBody?.restitution = 1
        enemy.name = "enemy"
        addChild(enemy)
        
        
        main = SKShapeNode(rectOf: paddleSize)
        main.position = CGPoint(x: frame.size.width/2, y: 30)
        main.fillColor = .blue
        main.physicsBody?.restitution = 1
        main.physicsBody = SKPhysicsBody(rectangleOf: main.frame.size)
        main.physicsBody?.isDynamic = false
        main.name = "player"
        main.physicsBody!.contactTestBitMask = main.physicsBody!.collisionBitMask
        main.physicsBody?.categoryBitMask = rectCategory
        addChild(main)
    
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody!.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = rectCategory
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        
        let baseSize = CGSize(width: 200, height: 60)

//        base = SKShapeNode(rectOf: baseSize)
//        base.position = CGPoint(x: frame.size.width/2, y: 10 )
//        base.fillColor = .white
//        base.physicsBody?.isDynamic = false
//        base.physicsBody?.contactTestBitMask = rectCategory
//        base.name = "ground"
//        addChild(base)
//
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.contactTestBitMask = 0
        border.friction = 0
        border.restitution = 1
        border.contactTestBitMask = 0
        border.categoryBitMask = frameCategory
        self.physicsBody = border
        startGame()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var ball: SKSpriteNode!
        var paddle: SKShapeNode!
        
        
        if contact.bodyA.node!.name == "ball" {
            ball = contact.bodyA.node as? SKSpriteNode
            paddle = contact.bodyB.node as? SKShapeNode
        } else {
            ball = contact.bodyB.node as? SKSpriteNode
            paddle = contact.bodyA.node as? SKShapeNode
        }
        
        if paddle.name == "player" {
            playerScore += 1
            bottomLabel.text = "\(playerScore)"
        }
        
        if playerScore == 5 {
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
//            levelUpLabel.text
        } else {
//            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
            
        }

    
    }

    
    func startGame() {
        bottomLabel.text = "\(playerScore)"
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
    
        
    }
}


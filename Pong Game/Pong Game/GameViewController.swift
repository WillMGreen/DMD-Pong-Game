import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var annotation: CustomAnnotation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  print(annotation.title)
        
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(fileNamed: "GameScene")!
    
           
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
        view.showsFPS = true
        view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

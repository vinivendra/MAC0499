


import Foundation
import SceneKit



let scene = SCNScene()

extension SCNScene {
    
    func addItem(item : Item) {
        rootNode.addChildNode(item.node)
    }
    
}






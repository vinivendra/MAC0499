// TODO: O vetor do ObjectsMenuController não tem que ser um vetor de classes, e sim um vetor de templates. Os nomes devem ser pegos de uma propriedade "name" do item (que pode espelhar o name do node). Os nomes das subclasses padrão podem ser fixos. É esse template que será usado para instanciar items aqui, no addItem.

import UIKit
import SceneKit
import EngineKit


class SceneManager: NSObject {

    static let shared = SceneManager()

    let scene = SCNScene.shared()

    func addItem(template: Item) {

        let instance = template.create()

        let camera = Camera.shared()
        let position = camera.position
        let rotation = Rotation(SCNVector4: camera.node.rotation)
        let defaultOrientation = Vector(x: 0, y: 0, z: -1)
        let newOrientation = rotation.rotate(defaultOrientation)

        let space = newOrientation.times(10)

        let newPosition = position.plus(space)

        instance.position = newPosition

        scene.addItem(instance);

    }

}

// TODO: O vetor do ObjectsMenuController não tem que ser um vetor de classes, e sim um vetor de templates. Os nomes devem ser pegos de uma propriedade "name" do item (que pode espelhar o name do node). Os nomes das subclasses padrão podem ser fixos. É esse template que será usado para instanciar items aqui, no addItem.

import UIKit
import SceneKit
import EngineKit


class SceneManager {

    static let shared = SceneManager()

    let selectedItem: Item

    let scene = SCNScene.shared()

    init() {
        let box = Box()
        selectedItem = box
        box.color = UIColor.blueColor()

        addItem(box)
    }

    func addItemFromTemplate(template: Item) {

        let instance = template.create()

        addItem(instance)
    }

    func addItem(item: Item) {
        let camera = Camera.shared()
        let position = camera.position
        let rotation = Rotation(SCNVector4: camera.node.rotation)
        let defaultOrientation = Vector(x: 0, y: 0, z: -1)
        let newOrientation = rotation.rotate(defaultOrientation)

        let space = newOrientation.times(10)

        let newPosition = position.plus(space)

        item.position = newPosition

        scene.addItem(item);
    }

}



import EngineKit


class TemplateEditorSceneManager: EditorSceneManager {
    var topItem: Item? {
        get {
            for node in scene.rootNode.childNodes {
                let item = node.item
                if let _ = item as? Light {
                }
                else if let _ = item as? Camera {
                }
                else {
                    return item
                }
            }

            return nil
        }
    }

    override init () {
        super.init()

        scene.addItem(Item.create())
    }

    override init!(script filename: String!) {
        super.init(script: filename)
    }

    override init!(script scriptFilename: String!, scene sceneFilename: String!) {
        super.init(script: scriptFilename, scene: sceneFilename)

        scene.addItem(Item.create())
    }

    override func addItem(item: Item!) {
        super.addItem(item)

        topItem?.addItem(item)
    }
}

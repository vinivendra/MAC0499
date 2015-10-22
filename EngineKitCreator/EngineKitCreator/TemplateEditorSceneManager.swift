

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

    override var selectedItem: Item? {
        get {
            let value: JSValue = self.javaScript.context.objectForKeyedSubscript("selectedItem")
            let item = value.toObjectOfClass(Item) as? Item
            return item
        }
        set {
            self.javaScript.context.setObject(newValue, forKeyedSubscript:"selectedItem")
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



import EngineKit


class EditorSceneManager: SceneManager {
    var selectedItem: Item? {
        get {
            let value: JSValue = self.javaScript.context.objectForKeyedSubscript("selectedItem")
            return value.toObjectOfClass(Item) as? Item
        }
        set {
            self.javaScript.context.setObject(newValue, forKeyedSubscript:"selectedItem")
        }
    }
}

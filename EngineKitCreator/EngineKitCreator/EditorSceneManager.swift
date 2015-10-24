

import EngineKit


class EditorSceneManager: SceneManager {
    var selectedItem: Item? {
        get {
            let value: JSValue = self.javaScript.context.objectForKeyedSubscript("selectedItem")
            var item = value.toObjectOfClass(Item) as? Item
            while (item?.parent != item) {
                item = item?.parent
            }

            return item
        }
        set {
            self.javaScript.context.setObject(newValue, forKeyedSubscript:"selectedItem")
        }
    }
}

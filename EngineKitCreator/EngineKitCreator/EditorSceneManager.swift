

import EngineKit


class EditorSceneManager: SceneManager {
    var selectedItem: Item? {
        willSet {
            if selectedItem != newValue {
                selectedItem?.selected = false
                newValue?.selected = true
            }
        }
    }
}



import Foundation
import JavaScriptCore


let defaultFilename = "main.js"


class JavaScript {
    
    let context = JSContext.sharedContext()
    
    var script : String
    
    var loadFunction : JSValue?
    var updateFunction : JSValue?
    
    
    /*!
    Initializes the JavaScript manager object, reads the file and sets up the environment.
    
    :param: fileName The name of the script file to be loaded; defaults to "main.js".
    */
    init (fileName: String?) {
        
        if fileName != nil &&
           fileName != "" {
            
            script = FileHelper.openTextFile(defaultFilename)
        }
        else {
            script = FileHelper.openTextFile(fileName!)
        }
        
        setup()
    }
    
    /*!
    Initializes the JavaScript manager object, reads the "main.js" file and sets up the environment.
    */
    convenience init () {
        self.init(fileName: defaultFilename)
    }
    
    /*!
    Sets up the JavaScript environment
    */
    func setup() {
        
        let jsPrint: @objc_block AnyObject -> Void = { input in
            print(input)
        }
        
        // TODO: Make this work:
        context.setObject(unsafeBitCast(jsPrint, AnyObject.self), forKeyedSubscript: "print")
        context.setObject(console.self,                           forKeyedSubscript: "console")
    }
    
    /*!
    Loads the "main.js" script, grabbing all the needed functions and setting up the environment in the process.
    */
    func load() {
        
        context.evaluateScript(script)
        
        updateFunction = context.objectForKeyedSubscript("update")

        loadFunction   = context.objectForKeyedSubscript("load")
        loadFunction?.callWithArguments(nil)
    }

    /*!
    Calls the corresponding JavaScript function (if existent), passing dt as the only parameter.
    
    :param: dt The time passed between the last call to this update() function and the current call.
    */
    func update(dt : Double) {
    
        updateFunction?.callWithArguments([dt])
    }
    
}

/*!
Class used to enable "console.log(bla)" in JavaScript
*/
class console : NSObject {
    
    class func log(object : Any) {
        print(object)
    }
}

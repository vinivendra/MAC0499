

import Foundation
import JavaScriptCore


let defaultFilename = "main.js"

var JSContextInstance = JSContext()


class JavaScript {
    
    let context = JavaScript.sharedContext()
    
    var script : String
    
    var loadFunction : JSValue?
    var updateFunction : JSValue?
    
    
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

    
    convenience init () {
        self.init(fileName: defaultFilename)
    }

    class func sharedContext() -> JSContext {
        return JSContextInstance
    }
    
    func setup() {
        
        context.exceptionHandler = self.handleException
        
        
        let jsPrint: @objc_block AnyObject? -> Void = { input in
            console.log(input)
        }
        context.setObject(unsafeBitCast(jsPrint, AnyObject.self), forKeyedSubscript: "print")
        context.setObject(console.self,                           forKeyedSubscript: "console")
        
        
        context.setObject(Box(), forKeyedSubscript: "box")
    }
    
    
    func load() {
        
        context.evaluateScript(script)
        
        updateFunction = context.objectForKeyedSubscript("update")

        loadFunction   = context.objectForKeyedSubscript("load")
    }

    
    func update(dt : Double) {
    
        updateFunction?.callWithArguments([dt])
    }
    
    
    func handleException(context : JSContext!, value : JSValue!) {
        var contextName : String;
        
        if (context == self.context) {
            contextName = "the shared context"
        }
        else {
            contextName = "\(context)"
        }

        assertionFailure("Error (JavaScript): JSContext (\(contextName)) had a problem evaluating code:\n\(value).\n")
    }
    
}




@objc protocol consoleExports : JSExport {
    class func log(object : AnyObject?);
}

@objc class console : NSObject, consoleExports {
    
    class func log(object : AnyObject?) {
        
        if let optional: AnyObject = object {
            println(optional)
        }
        else {
            println("(null)")
        }
    }
}




@objc protocol CreatableExport : JSExport {
    class func create() -> JSValue
}


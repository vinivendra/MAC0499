//
//  FileHelper.swift
//  Project
//
//  Created by Vinicius Vendramini on 06/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation

class FileHelper {
    
    class func openTextFile(filename : String) -> String {
        
        let path = self.pathForFileName(filename)
        assert(path != nil,
               "Error (FileHelper): File not found: \"\(filename)\"")
        
        let error = NSErrorPointer()
        
        let contents = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: error)
        
        assert(contents != nil,
               "Error (FileHelper): Error reading text file: \"\(filename)\"")
        
        return contents!
    }
    
 
    class func pathForFileName(filename : String) -> String? {
        
        let filenameParts = split(filename, {$0 == "."}, maxSplit: Int.max, allowEmptySlices: false)
        assert(filenameParts.count >= 2,
               "Error (FileHelper): Invalid filename: \"\(filename)\". Filenames must have valid extensions.")
    
        let fileExtension = filenameParts.last
        
        var mutableFileName = filename
            mutableFileName.replaceRange(filename.rangeOfString(".\(fileExtension!)")!, with: "")
        
        let path = NSBundle.mainBundle().pathForResource(mutableFileName, ofType: fileExtension)
        
        return path
    }
    
}
//
//  ViewController.swift
//  Project
//
//  Created by Vinicius Vendramini on 06/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import UIKit
import JavaScriptCore


class ViewController: UIViewController {

    var javaScript = JavaScript()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scriptString = FileHelper.openTextFile("main.js")
        
        javaScript.load()
    }

}


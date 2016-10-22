//
//  LanguageFilter.swift
//  GithubDemo
//
//  Created by Satoru Sasozaki on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LanguageFilter: NSObject {
    
    static var keys: [String] = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"]
    var languageMap: [String:Bool]?
    
    override init() {
        languageMap = ["Java": true,
                        "JavaScript": true,
                        "Objective-C": true,
                        "Python": true,
                        "Ruby": true,
                        "Swift": true]
        super.init()
    }
    
    func isChecked(language: String) -> Bool {
        if let checked = languageMap![language] {
            return checked
        }
        return false
    }
    
    
}

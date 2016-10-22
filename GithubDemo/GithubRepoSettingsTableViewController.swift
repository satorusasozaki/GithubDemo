//
//  GithubRepoSettingsViewController.swift
//  GithubDemo
//
//  Created by Satoru Sasozaki on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class GithubRepoSettingsTableViewController: UITableViewController {

    var doneHandler: (((Int?), (LanguageFilter?)) -> Void)?
    
    @IBOutlet weak var minimumStarsSlider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    @IBAction func minimumStarsSliderValueChanged(_ sender: UISlider) {
        sliderValue.text = String(Int(sender.value))
    }
    
    @IBOutlet weak var javaCell: UITableViewCell!
    @IBOutlet weak var javaScriptCell: UITableViewCell!
    @IBOutlet weak var objectiveCCell: UITableViewCell!
    @IBOutlet weak var pythonCell: UITableViewCell!
    @IBOutlet weak var rubyCell: UITableViewCell!
    @IBOutlet weak var swiftCell: UITableViewCell!
    
    
    
    var languageFilter: LanguageFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue.text = String(Int(minimumStarsSlider.value))
        // Do any additional setup after loading the view.
        //languageFilter = LanguageFilter()
    }
    
    @IBAction func onSave(_ sender: AnyObject) {
        for i in 0..<6 {
            let indexPath = IndexPath(row: i, section: 1)
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark {
                switch i {
                case 0:
                    languageFilter?.java = true
                case 1:
                    languageFilter?.javaScript = true
                case 2:
                    languageFilter?.objectiveC = true
                case 3:
                    languageFilter?.python = true
                case 4:
                    languageFilter?.ruby = true
                case 5:
                    languageFilter?.swift = true
                default:
                    break
                }
            } else {
                switch i {
                case 0:
                    languageFilter?.java = true
                case 1:
                    languageFilter?.javaScript = true
                case 2:
                    languageFilter?.objectiveC = true
                case 3:
                    languageFilter?.python = true
                case 4:
                    languageFilter?.ruby = true
                case 5:
                    languageFilter?.swift = true
                default:
                    break
                }
            }

            
        }
        
        doneHandler?(Int(minimumStarsSlider.value), languageFilter)
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func onCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCell = tableView.cellForRow(at: indexPath)
        print("indexPath: \(indexPath)")
        print("indexPath.row: \(indexPath.row)")
        print("indexPath.section: \(indexPath.section)")
        if newCell?.accessoryType == .none {
            print(filteredLanguages)
            newCell?.accessoryType = .checkmark
            if newCell == javaCell {
                filteredLanguages?.append("Java")
            } else if newCell == javaScriptCell {
                filteredLanguages?.append("JavaScript")
            } else if newCell == objectiveCCell {
                filteredLanguages?.append("Objective-C")
            } else if newCell == pythonCell {
                filteredLanguages?.append("Python")
            } else if newCell == rubyCell {
                filteredLanguages?.append("Ruby")
            } else if newCell == swiftCell {
                filteredLanguages?.append("Swift")
            }

        } else {
            newCell?.accessoryType = .none
        }
        
        
    }
    
}

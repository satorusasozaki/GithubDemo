//
//  GithubRepoSettingsViewController.swift
//  GithubDemo
//
//  Created by Satoru Sasozaki on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class GithubRepoSettingsTableViewController: UITableViewController {

    var doneHandler: ((Int?) -> Void)?
    
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
    
    
    
    var filteredLanguages: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue.text = String(Int(minimumStarsSlider.value))
        // Do any additional setup after loading the view.
        filteredLanguages = [String]()
    }
    
    @IBAction func onSave(_ sender: AnyObject) {
        let indexPath = IndexPath(row: 0, section: 1)
        let cell = tableView.cellForRow(at: indexPath)
        print("cell: \(cell)")
        doneHandler?(Int(minimumStarsSlider.value))
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

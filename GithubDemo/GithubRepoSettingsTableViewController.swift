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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue.text = String(Int(minimumStarsSlider.value))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSave(_ sender: AnyObject) {
        doneHandler?(Int(minimumStarsSlider.value))
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func onCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCell = tableView.cellForRow(at: indexPath)
        newCell?.accessoryType = .none
        
        if newCell?.accessoryType == .checkmark {
            
            
        } else {
            
        }
        
        
    }
    
}

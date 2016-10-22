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
    
    var languageFilter: LanguageFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue.text = String(Int(minimumStarsSlider.value))
        //languageFilter = LanguageFilter()
        tableView.isScrollEnabled = false
        for i in 0..<6 {
            let indexPath = IndexPath(row: i, section: 1)
            let cell = tableView.cellForRow(at: indexPath)
            if (languageFilter?.languageMap?[LanguageFilter.keys[i]])! {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func onSave(_ sender: AnyObject) {
        for i in 0..<6 {
            let indexPath = IndexPath(row: i, section: 1)
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark {
                languageFilter?.languageMap?[LanguageFilter.keys[i]] = true
            } else {
                languageFilter?.languageMap?[LanguageFilter.keys[i]] = false
            }
        }
//        for (key, value) in (languageFilter?.languageMap)! {
//            print("Key: \(key)\tValue: \(value)")
//        }
        
        doneHandler?(Int(minimumStarsSlider.value), languageFilter)
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func onCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    @IBOutlet weak var swiftCell: UITableViewCell!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) == swiftCell {
            if swiftCell.accessoryType == .checkmark {
               swiftCell.accessoryType = .none
            } else {
                swiftCell.accessoryType = .checkmark
            }
        } else {
            let newCell = tableView.cellForRow(at: indexPath)
            if newCell?.accessoryType == .none {
                languageFilter?.languageMap?[LanguageFilter.keys[indexPath.row]] = true
                newCell?.accessoryType = .checkmark
            } else {
                languageFilter?.languageMap?[LanguageFilter.keys[indexPath.row]] = false
                newCell?.accessoryType = .none
            }
        }
        tableView.reloadData()
        
    }
    
}

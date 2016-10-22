//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    
    var minimumStars: Int?
    var languageFilter: LanguageFilter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up tableView
        tableView.dataSource = self
        tableView.delegate = self
        // why is this?
        //tableView.register(RepoResultsTableViewCell.self, forCellReuseIdentifier: "RepoResultsTableViewCell")
        
        tableView.estimatedRowHeight = 224
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            print("\n\n\n\n\n\n")
            self.repos = newRepos
            print(self.repos)
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    // http://stackoverflow.com/questions/25444213/presenting-viewcontroller-with-navigationviewcontroller-swift
    // Present view controller modally with navigation bar
    @IBAction func onSettings(_ sender: UIBarButtonItem) {
        let settingsNVC = storyboard?.instantiateViewController(withIdentifier: "GithubRepoSettingsNavigationController") as! UINavigationController
         self.present(settingsNVC, animated: true, completion: {})
        let settingsVC = settingsNVC.viewControllers[0] as! GithubRepoSettingsTableViewController
        settingsVC.doneHandler = {(minimum: Int?, langFilter: LanguageFilter?) -> Void in
            self.minimumStars = minimum
            self.languageFilter = langFilter
            print(minimum!)
            var newRepos = [GithubRepo]()
            for repo in self.repos!{
                if repo.stars! > minimum! {
                    if let language = repo.language {
                        if self.languageFilter!.isChecked(language: language) {
                            newRepos.append(repo)
                        }
                    } 
                }
            }
            self.repos = newRepos
            self.tableView.reloadData()
        }
    }
}

extension RepoResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if let repos = repos {
            numberOfRows = repos.count
        } else {
            numberOfRows = 0
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoResultsTableViewCell", for: indexPath) as! RepoResultsTableViewCell
        //let cell = RepoResultsTableViewCell()
        //cell.textLabel?.text = repos[indexPath.row].repoDescription
        let repo = repos[indexPath.row]
        cell.titleLabel.text = repo.name
        //cell.starLabel.text = "Star: \(String(repo.stars!))"
        cell.starLabel.text = String(repo.stars!)
        //cell.forkLabel.text = "Fork: \(String(repo.forks!))"
        cell.forkLabel.text = String(repo.forks!)
        cell.usernameLabel.text = repo.ownerHandle
        cell.profileImageView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
        cell.descriptionLabel.text = repo.repoDescription
        
        return cell
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}

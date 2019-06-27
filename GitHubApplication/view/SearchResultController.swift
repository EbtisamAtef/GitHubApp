//
//  ViewController.swift
//  GitHubApplication
//
//  Created by eetewy on 6/24/19.
//  Copyright © 2019 eetewy. All rights reserved.
//

import UIKit
import Kingfisher


class SearchResultController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var gitHubSearchText: UISearchBar!
    
    @IBOutlet weak var searchResultTable: UITableView!
    
    var searchResultViewModel:SearchResulViewModel?
    let resultIdentifier = "SearchResultCell"
    var gitApiUrls = [URL]()
    var searchGithubResults = [Items]()
    var total_count:Int?
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultTable.dataSource = self
        self.searchResultTable.delegate = self
        self.searchResultViewModel = SearchResulViewModel(gitDataDelegate: self)
        self.gitHubSearchText.delegate = self
        self.searchResultTable.estimatedRowHeight = 120
        self.searchResultTable.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: resultIdentifier)
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let gitHubSearchBarText = gitHubSearchText.text
        searchResultViewModel!.getSearchRepo(url: Constant.searchResultUrl, searchTerm: gitHubSearchBarText!, currenPage: currentPage)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let gitHubSearchBarText = gitHubSearchText.text
        if gitHubSearchBarText!.isEmpty == true {
            searchGithubResults.removeAll()
            currentPage = 1
        }
        self.searchResultTable.reloadData()
    }
    
   


}


extension SearchResultController:UITableViewDataSource, UITableViewDelegate, GitDataProtocol{
    func didLoadGitData(item: [Items], totalResults: Int) {
        self.searchGithubResults.append(contentsOf: item)
        self.total_count = totalResults
        if totalResults == 0 {
            let alert = UIAlertController(title: "Not found", message: "Your Search Results Not found Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
        self.searchResultTable.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGithubResults.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let serachResultCell = tableView.dequeueReusableCell(withIdentifier: resultIdentifier, for: indexPath) as? SearchResultCell
        serachResultCell?.name?.text = self.searchGithubResults[indexPath.row].name
        serachResultCell?.repoName?.text = self.searchGithubResults[indexPath.row].full_name
        if let imageUrl = self.searchGithubResults[indexPath.row].owner.avatar_url{
            let url = URL(string: imageUrl)
            let defaultImage = UIImage(named: "defaultImage")
            serachResultCell?.userImage?.kf.setImage(with: url, placeholder: defaultImage)
            
        }
        return serachResultCell ?? UITableViewCell()
    }

    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == searchGithubResults.count - 1) && (searchGithubResults.count < total_count!){
            currentPage += 1
            searchResultViewModel!.getSearchRepo(url: Constant.searchResultUrl, searchTerm: gitHubSearchText.text!, currenPage: currentPage)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked on cell")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserDetails") as! RepoDetailsViewController
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
  
}



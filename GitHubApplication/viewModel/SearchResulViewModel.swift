//
//  SearchResultPresenter.swift
//  GitHubApplication
//
//  Created by eetewy on 6/24/19.
//  Copyright © 2019 eetewy. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol GitDataProtocol:class{
    func didLoadGitData(item:[Items],totalResults:Int)
}


class SearchResulViewModel:NSObject{

    weak var gitDataDelegate : GitDataProtocol?
    var gitHubApi:GithubAbi?

    init(gitDataDelegate:GitDataProtocol) {
        self.gitDataDelegate = gitDataDelegate
        self.gitHubApi = GithubAbi()
    }
    
  

}

extension SearchResulViewModel{
    
    
    func getSearchRepo(url:String, searchTerm:String, currenPage:Int){
        let url = String(format:url, searchTerm , "\(currenPage)")
        print(currenPage)
        gitHubApi?.getApiData(url: url, completion: { (apiData,success) in
            if success{
                do{
                    let jsonData = apiData.data(using: .utf8)
                    let searchoGithubResult = try  JSONDecoder().decode(SearchResultModel.self, from: jsonData ?? Data())
                    let totalResult = searchoGithubResult.total_count
                    self.gitDataDelegate?.didLoadGitData(item: searchoGithubResult.items, totalResults: totalResult!)
                }catch let error as NSError{
                    print("cant load data \(error)")
                }
                
            }else{
                print("notload")
            }
        })
        
    }
    
    
    func getUserDetails(){
        
    }
    
    
}

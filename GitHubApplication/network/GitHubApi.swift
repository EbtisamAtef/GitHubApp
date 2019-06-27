//
//  File.swift
//  GitHubApplication
//
//  Created by eetewy on 6/25/19.
//  Copyright © 2019 eetewy. All rights reserved.
//

import Foundation
import Alamofire

class GithubAbi:NSObject{
    
    func getApiData(url: String, completion: @escaping ((_ apiData: String, _ success:Bool) -> Void)) {
        Alamofire.request(url, method: .get).responseString() { (response) in
            if response.result.isSuccess {
                completion(response.result.value!,true)
            } else {
                completion(response.result.error! as! String,false)
            }
        }
    }
}

//
//  File.swift
//  GitHubApplication
//
//  Created by eetewy on 6/24/19.
//  Copyright © 2019 eetewy. All rights reserved.
//

struct SearchResultModel:Codable{
    var total_count:Int?
    var incomplete_results:Bool?
    var items : [Items]
    
}

struct Items:Codable{
    var id:Int?
    var name:String?
    var html_url:String?
    var url:String?
    var language:String?
    var full_name:String
    var owner:Owner
}

struct Owner:Codable{
    var id:Int?
    var avatar_url:String?
    var url:String?
    var html_url:String?
}


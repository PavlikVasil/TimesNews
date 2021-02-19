//
//  StoreItem.swift
//  TimesNews
//
//  Created by Павел on 18.02.2021.
//

import Foundation

struct StoreItems: Codable{
    let results: [StoreItem]
}

struct StoreItem: Codable{
    var title: String
    var abstract: String
    var updated_date: String
    let multimedia: [Image]  
}

struct Image: Codable{
    var url: String
}

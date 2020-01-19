//
//  NewsModel.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import Foundation

struct NewsModel: Codable {
	var status: String
    var totalResults: Int
    var articles: [News]
}

struct News: Codable {
    var source: Source?
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String?
}

struct Source: Codable {
    var id: String?
    var name: String?
}

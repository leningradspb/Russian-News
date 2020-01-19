//
//  NewsService.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import Foundation

class NewsService {

	var newsModel: NewsModel?

	var newsCount: Int {
		newsModel?.articles.count ?? 0
	}

	func requestNews(completion: @escaping () -> Void) {
		guard let url = URL(string: Consts().urlString) else {return}

		var request = URLRequest(url: url)

		let task = URLSession.shared.dataTask(with: request) { data, response, error in

			if let error = error {
				completion()
				return
			}

			if let response = response {
				print(response)
			}

			guard let data = data else {
				completion()
				return
			}

			let news = try? JSONDecoder().decode(NewsModel.self, from: data)
			self.newsModel = news
			completion()
		}
		task.resume()
	}
}

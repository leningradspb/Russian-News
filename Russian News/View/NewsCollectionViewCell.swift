//
//  NewsCollectionViewCell.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var cellImageView: UIImageView!
	
	@IBOutlet weak var cellLabel: UILabel!
	var imageNews = UIImage()
	
	override func prepareForReuse() {
		super.prepareForReuse()

		cellImageView.image = nil
		cellLabel.text = nil
		
	}

	func update(newsItem: News?) {
		guard let item = newsItem else { return }

		cellLabel.text = item.title
		//cellImageView.image = getImage(item: item)
		//cellImageView.image =
	}

	func getImage(item: News) -> UIImage {

		guard let url = URL(string: item.urlToImage ?? "") else { return UIImage(named: "noImage")!}
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

			if let error = error {
				print(error)
				return
			}

			guard let data = data else { return }
			DispatchQueue.main.async { [weak self] in
				guard let self = self else {return}
				self.imageNews = UIImage(data: data)!
			}
		}
		task.resume()
		return imageNews
	}
}

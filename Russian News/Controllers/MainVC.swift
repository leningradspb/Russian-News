//
//  ViewController.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

	let newsService = NewsService()

	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationTitle()
		setupCollectionView()
		requestNews()
	}

	private func setupNavigationTitle() {
	self.navigationController?.navigationBar.topItem?.title = "ГЛАВНОЕ"
	}

	private func setupCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}

	private func requestNews() {
		newsService.requestNews { [weak self] in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return newsService.newsCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Consts().cellID, for: indexPath) as! NewsCollectionViewCell

		cell.cellLabel.text = newsService.newsModel?.articles[indexPath.row].title
		return cell
	}

	
}

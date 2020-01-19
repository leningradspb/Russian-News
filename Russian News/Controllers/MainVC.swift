//
//  ViewController.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

	private let newsService = NewsService()
	//var images = [UIImage]()
	private var refreshControl = UIRefreshControl()
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupNavigationTitle()
		setupCollectionView()
		requestNews()
		setupRefresh()
	}

	private func setupNavigationTitle() {
	self.navigationController?.navigationBar.topItem?.title = "ГЛАВНОЕ"
	}

	private func setupCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		//collectionView.layoutMargins = UIEdgeInsets(top: 5, left: 19, bottom: 5, right: 19)
		//collectionView.contentInsetAdjustmentBehavior = .automatic
	}

	private func requestNews() {
		newsService.requestNews { [weak self] in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}

	private func setupImages(index: IndexPath) {
		guard let url = URL(string: newsService.newsModel?.articles[index.row].urlToImage ?? "") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error)
                return
            }

            guard let data = data else {return}

            DispatchQueue.main.async {
				//self.images.append(UIImage(data: data)!)
               // cell.imageView.image = UIImage(data: data)
            }

        }
        task.resume()
	}

	private func setupRefresh() {
		   refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		   refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
		   collectionView.addSubview(refreshControl) // not required when using UITableViewController
	   }

	   @objc func refresh(sender:AnyObject) {
			  collectionView.reloadData()
			   refreshControl.endRefreshing()
		  }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return newsService.newsCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Consts().cellID, for: indexPath) as! NewsCollectionViewCell

		let item = newsService.getNews(indexPath: indexPath)
		cell.update(newsItem: item)
		guard let url = URL(string: newsService.newsModel?.articles[indexPath.row].urlToImage ?? "") else { return cell}
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

				if let error = error {
					print(error)
					return
				}

				guard let data = data else {return}

				DispatchQueue.main.async {
					//self.images.append(UIImage(data: data)!)
					cell.cellImageView.image = UIImage(data: data)
				}

			}
			task.resume()
			return cell
		}
}


extension MainVC: UICollectionViewDelegateFlowLayout {

    //MARK: Размер конкретной ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let paddigSpace = Consts().sectionInserts.left * (Consts().itemsPerRow)
        let avaliableWidth = view.frame.width - paddigSpace
        let avalibleHeight = (view.frame.height - paddigSpace) / 2
        let widthPerItem = avaliableWidth / Consts().itemsPerRow
        let height = CGFloat(avalibleHeight) * widthPerItem / CGFloat(avaliableWidth)

        return CGSize(width: widthPerItem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 5
    }
	
}

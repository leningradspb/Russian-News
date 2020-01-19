//
//  ViewController.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.navigationBar.topItem?.title = "ГЛАВНОЕ"
		

		NewsService().requestNews { (news, error) in
			print(news)
			print(error)
		}
	}


}


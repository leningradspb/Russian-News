//
//  URLStringEnum.swift
//  Russian News
//
//  Created by Eduard Sinyakov on 1/19/20.
//  Copyright © 2020 Eduard Siniakov. All rights reserved.
//

import Foundation

enum URLStringEnum: String {
	case main = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case business = "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case sports = "https://newsapi.org/v2/top-headlines?country=ru&category=sports&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case entertainment = "https://newsapi.org/v2/top-headlines?country=ru&category=entertainment&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case science = "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case technology = "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
	case health = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=38cb788a96184c2e92b3d0f803e0b3c4"
}

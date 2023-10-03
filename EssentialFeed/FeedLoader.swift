//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Rodrigo Higuera Aguilar on 02/10/23.
//

import Foundation

enum LoadFeedResult {
	case success([FeedItem])
	case error(Error)
}

protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}

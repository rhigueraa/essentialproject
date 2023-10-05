//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Rodrigo Higuera Aguilar on 02/10/23.
//

import Foundation

public enum LoadFeedResult {
	case success([FeedItem])
	case failure(Error)
}

public protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}

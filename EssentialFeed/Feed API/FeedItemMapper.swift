//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Rodrigo Higuera Aguilar on 04/10/23.
//

import Foundation

internal final class FeedItemsMapper {
	
	private struct Root: Decodable {
		let items: [Item]
		
		var feed: [FeedItem] {
			return self.items.map { $0.item }
		}
	}
	
	private struct Item: Decodable {
		let id: UUID
		let description: String?
		let location: String?
		let image: URL
		
		var item: FeedItem {
			return FeedItem(id: id, description: description, location: location, imageURL: image)
		}
	}
	
	private static let OK_200: Int = 200
		
	internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
		guard response.statusCode == OK_200,
			let root = try? JSONDecoder().decode(Root.self, from: data) else {
			return .failure(RemoteFeedLoader.Error.invalidData)
		}
		return .success(root.feed)
	}
}

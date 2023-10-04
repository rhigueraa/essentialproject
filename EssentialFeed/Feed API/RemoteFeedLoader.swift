//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Rodrigo Higuera Aguilar on 03/10/23.
//

import Foundation

public final class RemoteFeedLoader {
	private let client: HTTPClient
	private let url: URL
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public enum Result: Equatable {
		case success([FeedItem])
		case failure(Error)
	}
	
	
	public init(client: HTTPClient, url: URL) {
		self.client = client
		self.url = url
	}
	
	public func load(completion: @escaping (Result) -> Void) {
		client.get(from: url) { result in
			switch result {
			case .success(let data, let response):
				do {
					let items = try FeedItemsMapper.map(data, response)
					completion(.success(items))
				} catch {
					completion(.failure(.invalidData))
				}
			case .failure:
				completion(.failure(.connectivity))
				
			}
		}
	}
}

private class FeedItemsMapper {
	
	private struct Root: Decodable {
		let items: [Item]
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
	
	static let OK_200: Int = 200
	
	static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
		guard response.statusCode == OK_200 else {
			throw RemoteFeedLoader.Error.invalidData
		}
		let root = try JSONDecoder().decode(Root.self, from: data)
		return root.items.map { $0.item }
	}
}

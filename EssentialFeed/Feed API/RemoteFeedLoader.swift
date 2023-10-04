//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Rodrigo Higuera Aguilar on 03/10/23.
//

import Foundation

public enum HTTPClientResult {
	case success(Data, HTTPURLResponse)
	case failure(Error)
}

public protocol HTTPClient {
	func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

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
			case .success(let response):
				completion(.failure(.invalidData))
			case .failure(let error):
				completion(.failure(.connectivity))
				
			}
		}
	}
}

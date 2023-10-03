//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Rodrigo Higuera Aguilar on 02/10/23.
//

import XCTest

class RemoteFeedLoader {
	
}

class HTTPClient {
	var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

	func test_init_doesNotRequestDataFromURL() {
		let client = HTTPClient()
		_ = RemoteFeedLoader()

		XCTAssertNil(client.requestedURL)
	}

}

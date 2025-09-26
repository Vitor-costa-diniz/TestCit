//
//  TestCitTests.swift
//  TestCitTests
//
//  Created by Vitor Costa on 24/09/25.
//

import XCTest
@testable import TestCit

final class TestListViewModel: XCTestCase {
    var viewModel: ListViewModel!
    var mockService: MockNetworkingService!

    override func setUpWithError() throws {
        mockService = MockNetworkingService()
        viewModel = .init(networkingService: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    func testLoadPosts() async throws {
        await viewModel.loadPosts()
        
        XCTAssertEqual(viewModel.posts.count, 3)
        XCTAssertEqual(viewModel.posts.first?.title, "first post title")
    }
    
    func testLoadPostsWithError() async throws {
        mockService.shouldThrowError = true
        
        await viewModel.loadPosts()
    
        XCTAssertEqual(viewModel.errorType?.type, CaseType.post)
    }
    
    func testLoadComments() async throws {
        await viewModel.loadPostComments()
        
        XCTAssertEqual(viewModel.comments.count, 3)
        XCTAssertEqual(viewModel.comments.first?.email, "first@gmail.com")
    }
    
    func testLoadCommentsWithError() async throws {
        mockService.shouldThrowError = true
        
        await viewModel.loadPostComments()
    
        XCTAssertEqual(viewModel.errorType?.type, CaseType.comment)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

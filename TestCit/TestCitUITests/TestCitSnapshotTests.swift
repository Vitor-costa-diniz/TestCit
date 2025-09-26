//
//  TestCitSnapshotTests.swift
//  TestCitTests
//
//  Created by Vitor Costa on 25/09/25.
//

import XCTest
import SnapshotTesting
@testable import TestCit

final class TestCitSnapshotTests: XCTestCase {
    var viewModel: ListViewModel!
    var mockService: MockNetworkingService!
    
    override func setUpWithError() throws {
        mockService = MockNetworkingService()
        viewModel = ListViewModel(networkingService: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    @MainActor
    func testPostsListView() async throws {
        await viewModel.loadPosts()
        
        let listView = ListView(viewModel: self.viewModel)
        
        let layout = SwiftUISnapshotLayout.device(config: .iPhone13)
        
        assertSnapshot(of: listView, as: .image(precision: 1, layout: layout))
    }
    
    @MainActor
    func testPostsListFailedView() async throws {
        mockService.shouldThrowError = true
        await viewModel.loadPosts()
        
        let listView = ListView(viewModel: self.viewModel)
        
        let layout = SwiftUISnapshotLayout.device(config: .iPhone13)
        
        assertSnapshot(of: listView, as: .image(precision: 1, layout: layout))
    }
    
    @MainActor
    func testOpenPostShowCommentsView() async throws {
        await viewModel.loadPosts()
        let listView = ListView(viewModel: self.viewModel)
        
        viewModel.selectedPost = viewModel.posts[0]
        
        await viewModel.loadPostComments()
        
        let layout = SwiftUISnapshotLayout.device(config: .iPhone13)
        
        assertSnapshot(of: listView, as: .image(precision: 1, layout: layout))
    }
    
    @MainActor
    func testOpenPostShowCommentsFailedView() async throws {
        await viewModel.loadPosts()
        let listView = ListView(viewModel: self.viewModel)
        viewModel.selectedPost = viewModel.posts[0]
        
        mockService.shouldThrowError = true
        await viewModel.loadPostComments()
        
        let layout = SwiftUISnapshotLayout.device(config: .iPhone13)
        assertSnapshot(of: listView, as: .image(precision: 1, layout: layout))
    }
}

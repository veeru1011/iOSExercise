//
//  AlbumListViewModelTests.swift
//  iOSExerciseTests
//
//  Created by mac on 14/03/23.
//

import XCTest
@testable import iOSExercise

class AlbumListViewModelTests: XCTestCase {

    
    func test_User_ForDummyData() throws {
        let responseData = #"{"id": 2,"name": "veer","username": "veer","email":"v@tcs.com","phone": "12345678"}"#.data(using: .utf8)
        let networkService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        let dataFetchService = DataFetchService(networkService: networkService)
        let coordinator = AlbumListCoordinator(appDataService: dataFetchService)
        let viewModel = AlbumListViewModel(dataFetchService, coordinator: coordinator)
        viewModel.fetchUserAndAlbums()
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertNotNil(viewModel.user)
        XCTAssertEqual(viewModel.user?.name,"veer")
        viewModel.fetch()
        XCTAssertEqual(viewModel.albums.count, 0)
    }

}

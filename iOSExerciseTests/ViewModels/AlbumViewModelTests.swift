//
//  AlbumViewModelTests.swift
//  iOSExerciseTests
//
//  Created by mac on 14/03/23.
//

import XCTest
@testable import iOSExercise

class AlbumViewModelTests: XCTestCase {

    func test_User_ForDummyData() throws {
        let expectation = self.expectation(description: "user in proper format ")
        let rawData = #"{"userId": 2,"id": 1,"title": "t1"}"#.data(using: .utf8)
        guard let album = try? JSONDecoder().decode(UserAlbum.self, from: rawData!) else {
            return
        }
        let responseData = #"[{"albumId": 2,"id": 1,"title": "t1","url" : "url","thumbnailUrl" : "thumbnailUrl"},{"albumId": 2,"id": 2,"title": "t2"}]"#.data(using: .utf8)
        
        
        let networkService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        let dataFetchService = DataFetchService(networkService: networkService)
        let coordinator = AlbumListCoordinator(appDataService: dataFetchService)
        let viewModel = AlbumListViewModel(dataFetchService, coordinator: coordinator)
        viewModel.open(album)
        
        coordinator.albumViewModel?.fetch()
        XCTAssertEqual(coordinator.albumViewModel?.isLoading, true)
        XCTAssertNotNil(coordinator.albumViewModel?.photos)
        
        DispatchQueue.main.async {
            expectation.fulfill()
            XCTAssertEqual(coordinator.albumViewModel?.photos.count, 2)
        }
        wait(for: [expectation], timeout: 0.01)

    }

}

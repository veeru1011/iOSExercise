//
//  AppDataServiceTests.swift
//  iOSExerciseTests
//
//  Created by mac on 14/03/23.
//

import XCTest
@testable import iOSExercise

private class DataFetchMockService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

class AppDataServiceTests: XCTestCase {
    
    
    func test_User_ForDummyData() throws {
        let expectation = self.expectation(description: "user in proper format ")
        let responseData = #"{"id": 2,"name": "veer","username": "veer","email":"v@tcs.com","phone": "12345678"}"#.data(using: .utf8)
        let networkService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        let dataFetchService = DataFetchService(networkService: networkService)
        
        
        var user : User?
        
        dataFetchService.fetchUsers { result in
            user = try? result.get()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(user?.id, 2)
    }
    
    func test_UserAlbum_ForMockData() throws {
        let expectation = self.expectation(description: "response in proper formate ")
        let responseData = #"[{"userId": 2,"id": 1,"title": "t1"},{"userId": 2,"id": 2,"title": "t2"}]"#.data(using: .utf8)
        let networkService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        //let networkService = NetworkFetchService(sessionManager: SessionManager())
        let dataFetchService = DataFetchService(networkService: networkService)
        
        var albumList : [UserAlbum] = []
        
        dataFetchService.fetchAlbums(userId: 2) { result in
            albumList = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(albumList.count, 2)
    }
    
    func test_UserPhoto_ForMockData() throws {
        let expectation = self.expectation(description: "response in proper formate ")
        let responseData = #"[{"albumId": 2,"id": 1,"title": "t1","url" : "url","thumbnailUrl" : "thumbnailUrl"},{"albumId": 2,"id": 2,"title": "t2"}]"#.data(using: .utf8)
        let networkService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        //let networkService = NetworkFetchService(sessionManager: SessionManager())
        let dataFetchService = DataFetchService(networkService: networkService)
        
        var photos : [UserPhoto] = []
        
        dataFetchService.fetchPhotos(albumId: 2) { result in
            photos = (try? result.get()) ?? []
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(photos.count, 2)
    }

}

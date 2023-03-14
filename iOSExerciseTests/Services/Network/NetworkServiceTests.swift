//
//  NetworkServiceTests.swift
//  iOSExerciseTests
//
//  Created by mac on 14/03/23.
//

import XCTest
@testable import iOSExercise

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        completion(data, response, error)
    }
}

private struct MockModel: Decodable {
    let id: Int
    let name:String
}

class NetworkServiceTests: XCTestCase {
    
    private struct EndpointMock: URLRequestable {
        var path: String
        
        public func urlRequest() throws -> URLRequest {
            let url = URL(string: path)
            let request = URLRequest(url: url!)
            return request
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testResponseDataDecodableToMockModel() {
        
        let expectation = self.expectation(description: "response in MockModel")
        let responseData = #"{"id": 1,"name": "Hello"}"#.data(using: .utf8)
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "http://endpoint.com")) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForInValidResponse_DataNoDecodableToMockModel() {
        
        let expectation = self.expectation(description: "response in not proper format ")
        let responseData = #"{"type": 20}"#.data(using: .utf8)
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: responseData, error: nil))
        
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "http://endpoint.com")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForNoDataInResponse() {
        
        let expectation = self.expectation(description: "no data error")
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: response, data: nil, error: nil))
        
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "endpoint")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case AppError.nilData = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForReturnErrorInResponse() throws {
        let expectation = self.expectation(description: "Return statusCode error")
        
        let response = HTTPURLResponse(url: URL(string: "testing")!,
                                       statusCode: 400,
                                       httpVersion: "1.0",
                                       headerFields: [:])
        
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: response, data: nil, error: AppError.cancelled))
        
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "endpoint")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case AppError.badRequest = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testForResponseWhenErrorInStatusCode() throws {
        let expectation = self.expectation(description: "return error")
        let cancelledError = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: cancelledError))
        
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "endpoint")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case AppError.cancelled = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_ForReturnErrorInResponse_ForNotConnectedToInternet() throws {
        let expectation = self.expectation(description: "return error")
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let mockService = NetworkFetchService(sessionManager: NetworkSessionManagerMock(response: nil, data: nil, error: error))
        
        mockService.sendRequest(endpoint: Endpoint<MockModel>(path: "endpoint")) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case AppError.noConnection = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_forErrorNoconnection() {
        let expectation = self.expectation(description: "checking error")
        let error = AppError.noConnection
        if case AppError.noConnection = error {
            expectation.fulfill()
        } else {
            XCTFail("Wrong error")
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_forErrorCode404() {
        let expectation = self.expectation(description: "checking error")
        let sut = AppError(errorCode: 404, error: nil)
        if case AppError.notFound = sut {
            expectation.fulfill()
        } else {
            XCTFail("Wrong error")
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_forErrorCode400() {
        let expectation = self.expectation(description: "checking error")
        let sut = AppError(errorCode: 400, error: nil)
        if case AppError.badRequest = sut {
            expectation.fulfill()
        } else {
            XCTFail("Wrong error")
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func test_forUnknownErrorCode() {
        let expectation = self.expectation(description: "checking error")
        let sut = AppError(errorCode: 10992, error: nil)
        if case AppError.unknown(code: let code) = sut {
            XCTAssertEqual(code, "10992")
            expectation.fulfill()
        } else {
            XCTFail("Wrong error")
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_forGenricError() {
        let expectation = self.expectation(description: "checking error")
        let error = NSError(domain: "network", code: NSURLErrorUnknown, userInfo: nil)
        let sut = AppError(errorCode: 0, error: error)
        if case AppError.generic(_) = sut {
            expectation.fulfill()
        } else {
            XCTFail("Wrong error")
        }
        wait(for: [expectation], timeout: 0.01)
    }

}

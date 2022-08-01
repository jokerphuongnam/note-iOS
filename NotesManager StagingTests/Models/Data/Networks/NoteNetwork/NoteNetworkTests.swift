//
//  NoteNetworkTests.swift
//  NotesManager StagingTests
//
//  Created by pnam on 31/07/2022.
//

@testable import NotesManager_Staging
import XCTest
@_implementationOnly import Alamofire
@_implementationOnly import RxSwift
@_implementationOnly import RxTest
@_implementationOnly import RxCocoa
@_implementationOnly import RxBlocking
@_implementationOnly import Mocker

final class AFNoteNetworkTests: XCTestCase {
    private var mockSession: MockSession!
    private var sut: AFNoteNetwork!
    private var scheduler: TestScheduler!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        mockSession = .init(configuration: configuration)
        sut = AFNoteNetwork(session: mockSession)
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        mockSession = nil
        sut = nil
        scheduler = nil
        try super.tearDownWithError()
    }
    
    //MARK: - fetch notes
    
    /// Given
    /// - page are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_pageParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0, limit = 2, searchWords = "test"
        let query = "page=\(page)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: page, limit: nil, searchWords: nil).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
    }
    
    /// Given
    /// - limit are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_limitParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let limit = 2
        let query = "limit=\(limit)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: nil, limit: limit, searchWords: nil).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
    }
    
    /// Given
    /// - serarchWords are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_searchWordsParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let searchWords = "test"
        let query = "search_words=\(searchWords)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: nil, limit: nil, searchWords: searchWords).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
    }
    
    /// Given
    /// - page, limit are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_pageAndLimitParameters() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0, limit = 2
        let query = "limit=\(limit)&page=\(page)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: page, limit: limit, searchWords: nil).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
    }
    
    /// Given
    /// - page, searchWord are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_pageAndSearchWordsParameters() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 2, searchWords = "test"
        let query = "page=\(page)&search_words=\(searchWords)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: page, limit: nil, searchWords: searchWords).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
    }
    
    /// Given
    /// - limit, searchWord are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_limitAndSearchWordsParametes() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let limit = 2, searchWords = "test"
        let query = "limit=\(limit)&search_words=\(searchWords)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchNotes = sut.fetchNotes(page: nil, limit: limit, searchWords: searchWords).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
    }
    
    /// Given
    /// - page, limit, searchWord are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0, limit = 2, searchWords = "test"
        let query = "limit=\(limit)&page=\(page)&search_words=\(searchWords)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// WhensearchWords
        let fetchNotes = sut.fetchNotes(page: page, limit: limit, searchWords: searchWords).asObservable()
        _ = try fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(3, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
    }
    
    /// Given
    /// - page, limit, searchWord are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_fetchNotesSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0, limit = 2, searchWords = "test"
        let query = "limit=\(limit)&page=\(page)&search_words=\(searchWords)"
        let statusCode = 200
        let fetchNotesResponse = FetchNotesResponse(notes: [], hasPrePage: true, hasNextPage: true)
        let apiFetchNotesResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchNotesResponse)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// WhensearchWords
        let fetchNotes = sut.fetchNotes(page: page, limit: limit, searchWords: searchWords).asObservable()
        let response = try? fetchNotes.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(3, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(fetchNotesResponse, response!)
    }
    
    /// Given
    /// - page, limit, searchWord are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_fetchNotesError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0, limit = 2, searchWords = "test"
        let query = "limit=\(limit)&page=\(page)&search_words=\(searchWords)"
        let statusCode = 404
        let apiFetchNotesResponse = ApiResponse<FetchNotesResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiFetchNotesResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)?\(query)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// WhensearchWords
        let fetchNotes = sut.fetchNotes(page: page, limit: limit, searchWords: searchWords).asObservable()
        let responseBlocking = fetchNotes.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(3, mockSession.parameters?.count)
        XCTAssertEqual(page, mockSession.parameters?["page"] as? Int)
        XCTAssertEqual(limit, mockSession.parameters?["limit"] as? Int)
        XCTAssertEqual(searchWords, mockSession.parameters?["search_words"] as? String)
    }
}

extension FetchNotesResponse: Equatable {
    static func == (lhs: FetchNotesResponse, rhs: FetchNotesResponse) -> Bool {
        (lhs.notes, lhs.hasNextPage, lhs.hasPrePage) == (rhs.notes, rhs.hasNextPage, rhs.hasPrePage)
    }
}

extension NoteResponse: Equatable {
    static func == (lhs: NoteResponse, rhs: NoteResponse) -> Bool {
        (lhs.id, lhs.title, lhs.description, lhs.color, lhs.createAt, lhs.updateAt) == (rhs.id, rhs.title, rhs.description, rhs.color, rhs.createAt, rhs.updateAt)
    }
}

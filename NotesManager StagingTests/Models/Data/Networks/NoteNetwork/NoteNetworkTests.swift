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
    /// When: call fetch notes
    /// Then:
    /// - Call API with correct parameters
    func test_fetchNotes_pageParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes"
        let page = 0
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
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
    /// When: call fetch notes
    /// Then:
    /// - Call API with fetch notes error
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
    
    //MARK: - insert note
    
    /// Given
    /// - title are provided
    /// - mock success reponse for API calling
    /// When: call insert note
    /// Then:
    /// - Call API with correct parameters
    func test_insertNote_titleParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let title = "test title"
        let statusCode = 200
        let insertNoteResponse = InsertNoteResponse(id: "test id", title: title, description: "test description", color: "test color", createAt: 123, updateAt: 123)
        let apiInsertNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: insertNoteResponse)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: title, description: nil).asObservable()
        _ = try insertNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
    }
    
    /// Given
    /// - description are provided
    /// - mock success reponse for API calling
    /// When: call insert note
    /// Then:
    /// - Call API with correct parameters
    func test_insertNote_descriptionParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let description = "test description"
        let statusCode = 200
        let insertNoteResponse = InsertNoteResponse(id: "test id", title: "test title", description: description, color: "test color", createAt: 123, updateAt: 123)
        let apiInsertNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: insertNoteResponse)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: nil, description: description).asObservable()
        _ = try insertNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call insert note
    /// Then:
    /// - Call API with correct parameters
    func test_insertNote() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let title = "test title", description = "test title"
        let statusCode = 200
        let insertNoteResponse = InsertNoteResponse(id: "test id", title: title, description: description, color: "test color", createAt: 123, updateAt: 123)
        let apiInsertNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: insertNoteResponse)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: title, description: description).asObservable()
        _ = try insertNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call insert note
    /// Then:
    /// - Call API with correct parameters
    func test_insertNote_insertNoteSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let title = "test title", description = "test title"
        let statusCode = 200
        let insertNoteResponse = InsertNoteResponse(id: "test id", title: title, description: description, color: "test color", createAt: 123, updateAt: 123)
        let apiInsertNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: insertNoteResponse)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: title, description: description).asObservable()
        let response = try insertNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(insertNoteResponse, response!)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call insert note
    /// Then:
    /// - Call API with insert note error
    func test_insertNote_insertNoteError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let title = "test title", description = "test title"
        let statusCode = 404
        let apiInsertNoteResponse = ApiResponse<InsertNoteResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: title, description: description).asObservable()
        let responseBlocking = insertNote.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    //MARK: - update note
    
    /// Given
    /// - title are provided
    /// - mock success reponse for API calling
    /// When: call update note
    /// Then:
    /// - Call API with correct parameters
    func test_updateNote_titleParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/update-note"
        let id = "test id"
        let title = "test title"
        let statusCode = 200
        let updateNoteResponse = InsertNoteResponse(id: id, title: title, description: "test description", color: "test color", createAt: 123, updateAt: 123)
        let apiUpdateNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateNoteResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateNote = sut.updateNote(id: id, title: title, description: nil).asObservable()
        _ = try updateNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(id, mockSession.parameters?["id"] as? String)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
    }
    
    /// Given
    /// - description are provided
    /// - mock success reponse for API calling
    /// When: call update note
    /// Then:
    /// - Call API with correct parameters
    func test_updateNote_updateParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/update-note"
        let id = "test id"
        let description = "test description"
        let statusCode = 200
        let updateNoteResponse = InsertNoteResponse(id: id, title: "test title", description: description, color: "test color", createAt: 123, updateAt: 123)
        let apiUpdateNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateNoteResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateNote = sut.updateNote(id: id, title: nil, description: description).asObservable()
        _ = try updateNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(id, mockSession.parameters?["id"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call update note
    /// Then:
    /// - Call API with correct parameters
    func test_updateNote() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/update-note"
        let id = "test id"
        let title = "test title", description = "test title"
        let statusCode = 200
        let updateNoteResponse = InsertNoteResponse(id: id, title: title, description: description, color: "test color", createAt: 123, updateAt: 123)
        let apiUpdateNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateNoteResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateNote = sut.updateNote(id: id, title: title, description: description).asObservable()
        _ = try updateNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(3, mockSession.parameters?.count)
        XCTAssertEqual(id, mockSession.parameters?["id"] as? String)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call update note
    /// Then:
    /// - Call API with correct parameters
    func test_updateNote_updateNoteSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/update-note"
        let id = "test id"
        let title = "test title", description = "test title"
        let statusCode = 200
        let apiInsertNoteResponse = ApiResponse<InsertNoteResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateNote = sut.updateNote(id: id, title: title, description: description).asObservable()
        let responseBlocking = updateNote.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(3, mockSession.parameters?.count)
        XCTAssertEqual(id, mockSession.parameters?["id"] as? String)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call update note
    /// Then:
    /// - Call API with update note error
    func test_updateNote_updateNoteError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/insert-note"
        let title = "test title", description = "test title"
        let statusCode = 404
        let apiInsertNoteResponse = ApiResponse<InsertNoteResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiInsertNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.inserNote(title: title, description: description).asObservable()
        let responseBlocking = insertNote.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(title, mockSession.parameters?["title"] as? String)
        XCTAssertEqual(description, mockSession.parameters?["description"] as? String)
    }
    
    //MARK: - delete note
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call delete note
    /// Then:
    /// - Call API with correct parameters
    func test_deleteNote() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/delete-note"
        let id = "testid"
        let statusCode = 200
        let deleteNoteResponse = InsertNoteResponse(id: id, title: "test title", description: "test description", color: "test color", createAt: 123, updateAt: 123)
        let apiDeleteNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: deleteNoteResponse)
        let dataResult = try JSONEncoder().encode(apiDeleteNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)/\(id)")!, dataType: .json, statusCode: statusCode, data: [.delete: dataResult])
        mock.register()
        
        /// When
        let deleteNote = sut.deleteNote(id: id).asObservable()
        _ = try deleteNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)/\(id)", mockSession.endPoint)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call delete note
    /// Then:
    /// - Call API with correct parameters
    func test_deleteNote_deleteNoteSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/delete-note"
        let id = "testid"
        let statusCode = 200
        let deleteNoteResponse = InsertNoteResponse(id: id, title: "test title", description: "test description", color: "test color", createAt: 123, updateAt: 123)
        let apiDeleteNoteResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: deleteNoteResponse)
        let dataResult = try JSONEncoder().encode(apiDeleteNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)/\(id)")!, dataType: .json, statusCode: statusCode, data: [.delete: dataResult])
        mock.register()
        
        /// When
        let deleteNote = sut.deleteNote(id: id).asObservable()
        let response = try? deleteNote.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)/\(id)", mockSession.endPoint)
        XCTAssertNotNil(response)
        XCTAssertEqual(deleteNoteResponse, response!)
    }
    
    /// Given
    /// - title, description are provided
    /// - mock success reponse for API calling
    /// When: call delete note
    /// Then:
    /// - Call API with delete note error
    func test_deleteNote_deleteNoteError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "notes/delete-note"
        let id = "testid"
        let statusCode = 404
        let apiDeleteNoteResponse = ApiResponse<DeleteNoteResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiDeleteNoteResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)/\(id)")!, dataType: .json, statusCode: statusCode, data: [.delete: dataResult])
        mock.register()
        
        /// When
        let insertNote = sut.deleteNote(id: id).asObservable()
        let responseBlocking = insertNote.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)/\(id)", mockSession.endPoint)
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

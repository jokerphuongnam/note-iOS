//
//  UserNetworkTests.swift
//  NotesManager StagingTests
//
//  Created by pnam on 28/07/2022.
//

@testable import NotesManager_Staging
import XCTest
@_implementationOnly import Alamofire
@_implementationOnly import RxSwift
@_implementationOnly import RxTest
@_implementationOnly import RxCocoa
@_implementationOnly import RxBlocking
@_implementationOnly import Mocker

class UserNetworkTests: XCTestCase {
    private var mockSession: MockSession!
    private var sut: AFUserNetwork!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        mockSession = .init(configuration: configuration)
        sut = AFUserNetwork(session: mockSession)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        mockSession = nil
        sut = nil
        disposeBag = nil
        scheduler = nil
        try super.tearDownWithError()
    }
    
    /// Given
    /// - email, password are provided
    /// - mock success reponse for API calling
    /// When: call login
    /// Then:
    /// - Call API with correct parameters
    func test_login() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "login"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 200
        let loginResponse = LoginResponse(id: "id", email: email, password: password, name: "Fake name", gender: "Fake gender", token: "Fake token")
        let apiLoginResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: loginResponse)
        let dataResult = try JSONEncoder().encode(apiLoginResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let login = sut.login(email: email, password: password).asObservable()
        _ = try? login.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
    }
    
    /// Given
    /// - email, password are provided
    /// - mock success reponse for API calling
    /// When: call login
    /// Then:
    /// - Call API with correct response
    func test_login_loginSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "login"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 200
        let loginResponse = LoginResponse(id: "id", email: email, password: password, name: "Fake name", gender: "Fake gender", token: "Fake token")
        let apiLoginResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: loginResponse)
        let dataResult = try JSONEncoder().encode(apiLoginResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let login = sut.login(email: email, password: password).asObservable()
        let response = try login.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(loginResponse, response!)
    }
    
    /// Given
    /// - email, password are provided
    /// - mock success reponse for API calling
    /// When: call login
    /// Then:
    /// - Call API with login error
    func test_login_loginError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "login"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 404
        let apiLoginResponse = ApiResponse<LoginResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiLoginResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let login = sut.login(email: email, password: password).asObservable()
        let responseBlocking = login.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
    }
}

extension LoginResponse: Equatable {
    static func == (lhs: LoginResponse, rhs: LoginResponse) -> Bool {
        (lhs.id, lhs.email, lhs.password, lhs.name, lhs.gender, lhs.token) == (rhs.id, rhs.email, rhs.password, rhs.name, rhs.gender, rhs.token)
    }
}

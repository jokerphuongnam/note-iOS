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

final class AFUserNetworkTests: XCTestCase {
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
    
    // MARK: - login
    
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
        let loginResponse = LoginResponse(id: "id", email: email, name: "Fake name", gender: "Fake gender", token: "Fake token")
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
        let loginResponse = LoginResponse(id: "id", email: email, name: "Fake name", gender: "Fake gender", token: "Fake token")
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
    /// - mock error for API calling
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
    
    // MARK: - register
    
    /// Given
    /// - email, password are provided
    /// - mock success reponse for API calling
    /// When: call register
    /// Then:
    /// - Call API with correct parameters
    func test_register() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "register"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 200
        let registerResponse = RegisterResponse(id: "id", email: email, name: "Fake name", gender: "Fake gender")
        let apiRegisterResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: registerResponse)
        let dataResult = try JSONEncoder().encode(apiRegisterResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let register = sut.register(email: email, password: password).asObservable()
        _ = try? register.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
    }
    
    /// Given
    /// - email, password are provided
    /// - mock success reponse for API calling
    /// When: call register
    /// Then:
    /// - Call API with correct response
    func test_register_registerSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "register"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 200
        let registerResponse = RegisterResponse(id: "id", email: email, name: "Fake name", gender: "Fake gender")
        let apiRegisterResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: registerResponse)
        let dataResult = try JSONEncoder().encode(apiRegisterResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let register = sut.register(email: email, password: password).asObservable()
        let response = try register.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(registerResponse, response!)
    }
    
    /// Given
    /// - email, password are provided
    /// - mock error for API calling
    /// When: call register
    /// Then:
    /// - Call API with register error
    func test_register_registerError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "register"
        let email = "test@gmail.com", password = "12345678"
        let statusCode = 404
        let apiRegisterResponse = ApiResponse<LoginResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiRegisterResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.post: dataResult])
        mock.register()
        
        /// When
        let register = sut.register(email: email, password: password).asObservable()
        let responseBlocking = register.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(email, mockSession.parameters?["email"] as? String)
        XCTAssertEqual(password, mockSession.parameters?["password"] as? String)
    }
    
    // MARK: - fetch access token
    
    /// Given
    /// - login token are provided
    /// - mock success reponse for API calling
    /// When: call fetch access token
    /// Then:
    /// - Call API with correct parameters
    func test_fetchAccessToken() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "get-access-token"
        let loginToken = "fake request token"
        let statusCode = 200
        let fetchAccessTokenResponse: FetchAccessTokenResponse = "fake response token"
        let apiFecthAccessTokenResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchAccessTokenResponse)
        let dataResult = try JSONEncoder().encode(apiFecthAccessTokenResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchAccessToken = sut.fetchAccessToken(loginToken: loginToken).asObservable()
        _ = try? fetchAccessToken.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.httpHeaders?.count)
        XCTAssertEqual("Bearer \(loginToken)", mockSession.httpHeaders?["Authorization"] as? String)
    }
    
    /// Given
    /// - login token are provided
    /// - mock success reponse for API calling
    /// When: call fetch access token
    /// Then:
    /// - Call API with correct response
    func test_fetchAccessToken_fecthAccessTokenSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "get-access-token"
        let loginToken = "fake request token"
        let statusCode = 200
        let fetchAccessTokenResponse: FetchAccessTokenResponse = "fake response token"
        let apiFecthAccessTokenResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: fetchAccessTokenResponse)
        let dataResult = try JSONEncoder().encode(apiFecthAccessTokenResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchAccessToken = sut.fetchAccessToken(loginToken: loginToken).asObservable()
        let response = try fetchAccessToken.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.httpHeaders?.count)
        XCTAssertEqual("Bearer \(loginToken)", mockSession.httpHeaders?["Authorization"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(fetchAccessTokenResponse, response!)
    }
    
    /// Given
    /// - login token are provided
    /// - mock error for API calling
    /// When: call fetch access token
    /// Then:
    /// - Call API with access token error
    func test_fetchAccessToken_fetchAccessTokenError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "get-access-token"
        let loginToken = "fake request token"
        let statusCode = 404
        let apiFecthAccessTokenResponse = ApiResponse<FetchAccessTokenResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiFecthAccessTokenResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.get: dataResult])
        mock.register()
        
        /// When
        let fetchAccessToken = sut.fetchAccessToken(loginToken: loginToken).asObservable()
        let responseBlocking = fetchAccessToken.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.httpHeaders?.count)
        XCTAssertEqual("Bearer \(loginToken)", mockSession.httpHeaders?["Authorization"] as? String)
    }
    
    // MARK: - update profile
    
    /// Given
    /// - name are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_updateProfile_nameParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "update-profile"
        let name = "Test user", gender = "Test male"
        let statusCode = 200
        let updateProfileResponse = UpdateProfileResponse(id: "id", email: "testemail@gmail.com", name: name, gender: gender)
        let apiUpdateProfileResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateProfileResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateProfileResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateProfile = sut.updateProfile(name: name, gender: nil).asObservable()
        _ = try updateProfile.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(name, mockSession.parameters?["name"] as? String)
    }
    
    /// Given
    /// - gender are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_updateProfile_genderParameter() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "update-profile"
        let name = "Test user", gender = "Test male"
        let statusCode = 200
        let updateProfileResponse = UpdateProfileResponse(id: "id", email: "testemail@gmail.com", name: name, gender: gender)
        let apiUpdateProfileResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateProfileResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateProfileResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateProfile = sut.updateProfile(name: nil, gender: gender).asObservable()
        _ = try updateProfile.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(1, mockSession.parameters?.count)
        XCTAssertEqual(gender, mockSession.parameters?["gender"] as? String)
    }
    
    /// Given
    /// - name, gender are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct parameters
    func test_updateProfile_fullParameters() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "update-profile"
        let name = "Test user", gender = "Test male"
        let statusCode = 200
        let updateProfileResponse = UpdateProfileResponse(id: "id", email: "testemail@gmail.com", name: name, gender: gender)
        let apiUpdateProfileResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateProfileResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateProfileResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateProfile = sut.updateProfile(name: name, gender: gender).asObservable()
        _ = try updateProfile.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(name, mockSession.parameters?["name"] as? String)
        XCTAssertEqual(gender, mockSession.parameters?["gender"] as? String)
    }
    
    /// Given
    /// - name, gender are provided
    /// - mock success reponse for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with correct response
    func test_updateProfile_updateProfileSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "update-profile"
        let name = "Test user", gender = "Test male"
        let statusCode = 200
        let updateProfileResponse = UpdateProfileResponse(id: "id", email: "testemail@gmail.com", name: name, gender: gender)
        let apiUpdateProfileResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: updateProfileResponse)
        let dataResult = try JSONEncoder().encode(apiUpdateProfileResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateProfile = sut.updateProfile(name: name, gender: gender).asObservable()
        let response = try updateProfile.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(name, mockSession.parameters?["name"] as? String)
        XCTAssertEqual(gender, mockSession.parameters?["gender"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(updateProfileResponse, response!)
    }
    
    /// Given
    /// - name, gender are provided
    /// - mock error for API calling
    /// When: call update profile
    /// Then:
    /// - Call API with login error
    func test_updateProfile_updateProfileError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "update-profile"
        let name = "Test user", gender = "Test male"
        let statusCode = 404
        let apiUpdateProfileResponse = ApiResponse<UpdateProfileResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiUpdateProfileResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let updateProfile = sut.updateProfile(name: name, gender: gender).asObservable()
        let responseBlocking = updateProfile.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(name, mockSession.parameters?["name"] as? String)
        XCTAssertEqual(gender, mockSession.parameters?["gender"] as? String)
    }
    
    // MARK: - change password
    
    /// Given
    /// - oldPassword, newPassword are provided
    /// - mock success reponse for API calling
    /// When: call change password
    /// Then:
    /// - Call API with correct parameters
    func test_changePassword() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "change-password"
        let oldPassword = "oldPassword", newPassword = "newPassword"
        let statusCode = 200
        let changePasswordResponse = ChangePasswordResponse(id: "id", email: "fakeemail@gmail.com", name: "Fake name", gender: "Fake gender")
        let apiChangePasswordResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: changePasswordResponse)
        let dataResult = try JSONEncoder().encode(apiChangePasswordResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let changePassword = sut.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        _ = try? changePassword.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(oldPassword, mockSession.parameters?["old_password"] as? String)
        XCTAssertEqual(newPassword, mockSession.parameters?["new_password"] as? String)
    }
    
    /// Given
    /// - oldPassword, newPassword are provided
    /// - mock success reponse for API calling
    /// When: call change password
    /// Then:
    /// - Call API with correct response
    func test_changePassword_changePasswordSuccess() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "change-password"
        let oldPassword = "oldPassword", newPassword = "newPassword"
        let statusCode = 200
        let changePasswordResponse = ChangePasswordResponse(id: "id", email: "fakeemail@gmail.com", name: "Fake name", gender: "Fake gender")
        let apiChangePasswordResponse = ApiResponse(statusCode: statusCode, status: true, message: "", data: changePasswordResponse)
        let dataResult = try JSONEncoder().encode(apiChangePasswordResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let changePassword = sut.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        let response = try changePassword.toBlocking().first()
        
        /// Then
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(oldPassword, mockSession.parameters?["old_password"] as? String)
        XCTAssertEqual(newPassword, mockSession.parameters?["new_password"] as? String)
        XCTAssertNotNil(response)
        XCTAssertEqual(changePasswordResponse, response!)
    }
    
    /// Given
    /// - oldPassword, newPassword are provided
    /// - mock error for API calling
    /// When: call change password
    /// Then:
    /// - Call API with change password error
    func test_changePassword_changePasswordError() throws {
        /// Given
        let baseUrl = String.baseUrl
        let endPoint = "change-password"
        let oldPassword = "oldPassword", newPassword = "newPassword"
        let statusCode = 404
        let apiChangePasswordResponse = ApiResponse<ChangePasswordResponse>(statusCode: statusCode, status: false, message: "", data: nil)
        let dataResult = try JSONEncoder().encode(apiChangePasswordResponse)
        let mock = Mock(url: URL(string: "\(baseUrl)\(endPoint)")!, dataType: .json, statusCode: statusCode, data: [.patch: dataResult])
        mock.register()
        
        /// When
        let changePassword = sut.changePassword(oldPassword: oldPassword, newPassword: newPassword)
        let responseBlocking = changePassword.toBlocking()
        
        /// Then
        XCTAssertThrowsError(try responseBlocking.first())
        XCTAssertEqual("/\(endPoint)", mockSession.endPoint)
        XCTAssertEqual(2, mockSession.parameters?.count)
        XCTAssertEqual(oldPassword, mockSession.parameters?["old_password"] as? String)
        XCTAssertEqual(newPassword, mockSession.parameters?["new_password"] as? String)
    }
}

extension LoginResponse: Equatable {
    static func == (lhs: LoginResponse, rhs: LoginResponse) -> Bool {
        (lhs.id, lhs.email, lhs.name, lhs.gender, lhs.token) == (rhs.id, rhs.email, rhs.name, rhs.gender, rhs.token)
    }
}

extension RegisterResponse: Equatable {
    static func == (lhs: RegisterResponse, rhs: RegisterResponse) -> Bool {
        (lhs.id, lhs.email, lhs.name, lhs.gender) == (rhs.id, rhs.email, rhs.name, rhs.gender)
    }
}

extension UpdateProfileResponse: Equatable {
    static func == (lhs: UpdateProfileResponse, rhs: UpdateProfileResponse) -> Bool {
        (lhs.id, lhs.email, lhs.name, lhs.gender) == (rhs.id, rhs.email, rhs.name, rhs.gender)
    }
}

extension ChangePasswordResponse: Equatable {
    static func == (lhs: ChangePasswordResponse, rhs: ChangePasswordResponse) -> Bool {
        (lhs.id, lhs.email, lhs.name, lhs.gender) == (rhs.id, rhs.email, rhs.name, rhs.gender)
    }
}

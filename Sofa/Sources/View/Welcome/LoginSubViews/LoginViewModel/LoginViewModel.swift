//
//  LoginViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/18.
//

import Foundation
import Alamofire
import Combine

class LoginViewModel: ObservableObject {
  @Published var loginResponse: LoginResponse
  @Published var showJoin: Bool
  @Published var showContent: Bool
  @Published var accessToken: String
  @Published var userId: Int
  
  private var cancellables = Set<AnyCancellable>()    // disposeBag
  
  init(){
    loginResponse = LoginResponse(timestamp: "", status: 0, detail: "", type: "", authToken: "", userId: 0)
    showJoin = false
    showContent = false
    accessToken = ""
    userId = 0
  }
  
  func toggleJoin(){
    showJoin.toggle()
  }
  
  func toggleLogin(){
    showContent.toggle()
  }
  
  func postKakaoLogin(accessToken: String, refreshToken: String){
    print("LoginViewModel - postKakaoLogin() called")
    
    AF.request(LoginManager.postkakaoLogin(accessToken: accessToken, refreshToken: refreshToken))
      .publishDecodable(type: LoginResponse.self)
      .value()
      .print()
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink(
        receiveCompletion: {[weak self] in
          guard case .failure(let error) = $0 else { return }
          switch error.responseCode {
          case 200:
            print("Success")
          case 400: // 요청 에러 발생했을 때
            break
          case 500: // 서버의 내부적 에러가 발생했을 때
            break
          default:
            break
          }
          NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: {[weak self] receivedValue in
          if receivedValue.status != nil{
            switch receivedValue.status {
            case 400: // 요청 에러 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            case 500: // 서버의 내부적 에러가 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            default:
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            }
          }else{ // Success
            self?.loginResponse = receivedValue
            if self?.loginResponse.type == "join"{ // 첫 로그인 (회원가입)
              self?.accessToken = (self?.loginResponse.authToken)!
              self?.userId = (self?.loginResponse.userId)!
              self?.toggleJoin()
              print("ACCESSTOKEN: \(self?.accessToken ?? "") USERID: \(self?.userId ?? 0)")
            }else if self?.loginResponse.type == "login"{ // 재 로그인
              Constant.accessToken = self?.loginResponse.authToken
              Constant.userId = self?.loginResponse.userId
              self?.accessToken = (self?.loginResponse.authToken)!
              self?.userId = (self?.loginResponse.userId)!
              self?.toggleLogin()
            }
            
          }
        }
      )
      .store(in: &cancellables)   // disposed(by: disposeBag)
  }
  
  func postAppleLogin(identityToken: String, authoriztionCode: String, userId: String){
    print("LoginViewModel - postAppleLogin() called")
    
    AF.request(LoginManager.postappleLogin(identityToken: identityToken, authoriztionCode: authoriztionCode, userId: userId))
      .publishDecodable(type: LoginResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink(
        receiveCompletion: {[weak self] in
          guard case .failure(let error) = $0 else { return }
          NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: {[weak self] receivedValue in
          if receivedValue.status != nil{
            switch receivedValue.status {
            case 400: // 요청 에러 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            case 500: // 서버의 내부적 에러가 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            default:
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            }
          }else{ // Success
            self?.loginResponse = receivedValue
            if self?.loginResponse.type == "join"{ // 첫 로그인 (회원가입)
              self?.accessToken = (self?.loginResponse.authToken)!
              self?.userId = (self?.loginResponse.userId)!
              self?.toggleJoin()
              print("ACCESSTOKEN: \(self?.accessToken ?? "") USERID: \(self?.userId ?? 0)")
              print("JOIN")
            }else if self?.loginResponse.type == "login"{ // 재 로그인
              Constant.accessToken = self?.loginResponse.authToken
              Constant.userId = self?.loginResponse.userId
              self?.accessToken = (self?.loginResponse.authToken)!
              self?.userId = (self?.loginResponse.userId)!
              self?.toggleLogin()
              print("LOGIN")
            }
            
          }
        }
      )
      .store(in: &cancellables)   // disposed(by: disposeBag)
    
  }
  
}

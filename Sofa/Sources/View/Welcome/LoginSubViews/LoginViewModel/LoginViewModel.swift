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

  private var cancellables = Set<AnyCancellable>()    // disposeBag
  
  init(){
    loginResponse = LoginResponse(type: "", authToken: "")
  }

  func postKakaoLogin(accessToken: String, refreshToken: String){
    print("LoginViewModel - postKakaoLogin() called")
//    print(accessToken)
//    print(refreshToken)
    
//    AF.request(LoginManager.postkakaoLogin(accessToken: accessToken, refreshToken: refreshToken)).responseJSON { (response) in
//
//
//        print(response)
//
//    }
    
//    AF.request(LoginManager.postkakaoLogin(accessToken: accessToken, refreshToken: refreshToken)).response { (response) in
//      switch response.result{
//      case .success:
//        print("성공")
//      case .failure(let error):
//        print(error)
//      }
//    }
//    AF.request(LoginManager.postkakaoLogin(accessToken: accessToken, refreshToken: refreshToken)).responseDecodable(of: LoginResponse.self) { response in
//      let propertyResponse = response.map { $0 }
//
//      debugPrint(propertyResponse)
//    }

//    AF.request(LoginManager.postkakaoLogin(accessToken: accessToken, refreshToken: refreshToken))
//      .publishDecodable(type: LoginResponse.self)
//      .value()
//      .print()
//      .receive(on: DispatchQueue.main)
//      .map { $0 }
//      .sink(
//        receiveCompletion: {[weak self] in
//          guard case .failure(let error) = $0 else { return }
//          switch error.responseCode {
//          case 200:
//            print("Success")
//          case 400: // 요청 에러 발생했을 때
//            break
//          case 500: // 서버의 내부적 에러가 발생했을 때
//            break
//          default:
//            break
//          }
//          NSLog("Error : " + error.localizedDescription)
////          self?.albumDateList = [AlbumDate]()
//        },
//        receiveValue: {[weak self] receivedValue in
//          print("받은 값 : \(receivedValue.type)")
////          self?.loginResponse = receivedValue
//        }
//      )
//      .store(in: &cancellables)   // disposed(by: disposeBag)
  }

}

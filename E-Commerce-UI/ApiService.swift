//
//  MovieApiService.swift
//  ExploringXcode
//
//  Created by ahmadmedo on 9/7/21.
//
import Alamofire


class ApiService {
    static let shared = ApiService()
    
    let url = "https://fakestoreapi.com/products"
    let authenticationURL = "https://fakestoreapi.com/auth/login"
    let signUpURL = "https://fakestoreapi.com/users"
    
    
    func signUpApi(parameters:Dictionary<String,Any>,completion: @escaping(User?)->Void, onError: @escaping(String)->Void){
        AF.request(signUpURL,method: .post,parameters: parameters,encoding: JSONEncoding.default).responseData{ (data) in
            guard data.data != nil,data.response?.statusCode != nil
            else{
                onError("response or data is invalid")
                return
            }
            if data.response?.statusCode == 200 {
                if let model = data.data{
                    let userModel = Coder().decode(toType: User.self, from: model)
                    completion(userModel)
                }else{
                    onError("unimplemented error")
                }
            }else{
                onError("Sign Up failed!")
            }
        }
    }
    
    
    
    func loginApi(parameters:[String:Any],completion: @escaping(Token?)->Void, onError: @escaping(String)->Void){
        
        AF.request(authenticationURL,method: .post,parameters: parameters,encoding: JSONEncoding.default).responseData{ (data) in
            guard data.data != nil,data.response?.statusCode != nil
            else{
                onError("response or data is invalid")
                return
            }
            if data.response?.statusCode == 200 {
                if let model = data.data{
                    let tokenModel = Coder().decode(toType: Token.self, from: model)
                    completion(tokenModel)
                }else{
                    onError("unimplemented error")
                }
            }else{
                onError("username or password is incorrect")
            }
        }
    }
    
    func getHomeData(completion: @escaping(FeaturedListModel?)-> Void, onError: @escaping (String)->Void){
        
// both completion & onError are escaping Closures
// 1- no return ()->Void
        AF.request(url, method: .get,headers: nil).responseData{ (data) in
            // data from closure have data.data & data.response
            guard data.data != nil,data.response?.statusCode != nil
            // if empty data or response is wrong
            else{
// onError(type-declared-previosly)
                onError("invalid data or response")
                return
            }
        
          if data.response?.statusCode == 200 {
                if let dataModel = data.data{
                    let model = Coder().decode(toType: FeaturedListModel.self, from: dataModel)
// completion(type-declared-previosly)
                    completion(model)
                }
            }else{
// onError(type-declared-previosly)
                onError("status code is not 200")
            }
        }
    }
}


//
//  LocationUtils.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import Alamofire

class APIRequest {
    
    /// Request URL
    var url = String()
    
    
    /// Request Method (Default Get)
    var method = HTTPMethod.get
    
    
    /// Parameters to be passed with the Request
    var parameters: Dictionary<String,Any>?
    
    
    /// Headers to be passed with the Request
    var headers: Dictionary<String,String>?
    
    
    /// Timeout for Request
    var requestTimeout: TimeInterval?
    
    
    /// Default init method
    init() {
    }
    
    
    /// intialize the APIRequest class
    /// - Parameters:
    ///   - url: request url
    ///   - method: request method
    ///   - viewForIndicator: shows activity indicator if true
    init(url: String, method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    func getHeaders() -> HTTPHeaders? {
        if headers != nil {
            return HTTPHeaders(headers!)
        }
        return nil
    }
}


/// Response Header Type
typealias ResponseHeaders = [AnyHashable : Any]

/// Response Closure
typealias APIResponse = (_ responseJSON: Any?, _ responseHeaders: ResponseHeaders?, _ error: String?) -> Swift.Void


class APIManager {
    
    
    /// Default request timeout interval
    fileprivate static let Default_Timeout: TimeInterval = 10
    
    
    /// Make server request
    ///
    /// - Parameters:
    ///   - request: request object containg url and method
    ///   - apiResponse: response received from the server
    static func request(_ apiRequest: APIRequest, apiResponse: APIResponse?) {
        // Common headers
        if nil == apiRequest.headers {
            apiRequest.headers = Dictionary<String,String>()
        }
        apiRequest.headers!["Content-Type"] = "application/json"
        apiRequest.headers!["Accept"] = "application/json"
        
        // Session manager and request
        let manager = Alamofire.Session.default
        manager.request(apiRequest.url, method: apiRequest.method, parameters: apiRequest.parameters, encoding: URLEncoding.default, headers: apiRequest.getHeaders()).responseString { (dataResponse) in
            var errorDescription: String? = nil
            if let error = dataResponse.error {
                print(items: "Error: \(error)")
                errorDescription = error.underlyingError?.localizedDescription ?? error.localizedDescription
            }
            // Call the completion handler
            var response: Any? = nil
            switch dataResponse.result {
            case .success(let resp):
                response = resp
                break
            case .failure(let error):
                if errorDescription == nil {
                    errorDescription = error.errorDescription
                }
                break
            }
            if nil != apiResponse {
                apiResponse!(response, dataResponse.response?.allHeaderFields, errorDescription)
            }
        }
    }
    
}


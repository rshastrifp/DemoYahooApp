//
//  APIClient.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation

typealias SuccessData = (_ data: Data) -> Void
typealias Failure = (_ error: Any) -> Void

class ApiClient {
    public func execute(api: API, params: [String: String], success: @escaping SuccessData, failure: @escaping Failure) {
        
        guard let url = URL(string: api.uri) else { return }
        
        var urlComp = URLComponents(string: api.uri)!
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        
        //Alamofire can also be used here for many advanced functions of web API.
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Not a valid Response.")
                return
            }
            
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                print("Status code was \(httpResponse.statusCode), but expected 2xx")
                failure(httpResponse.statusCode)
                return
            }
            
            success(data)
        }).resume()
    }
    
    
}

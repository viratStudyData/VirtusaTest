//
//  HTTPClint.swift
//  VirtusaTest
//
//  Created by Virat on 10/12/23.
//

import Foundation

typealias HttpClientSuccess = (Any?, Data?) -> ()
typealias HttpClientFailure = (Error?) -> ()

protocol NetworkingService {
    func fetchRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )
}

class HTTPClient: NetworkingService {
    func fetchRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure ){
        
        let params = api.parameters
        let fullPath = api.baseURL + api.route
        
        
        var request: URLRequest?
        
        var urlComponent = URLComponents(string: fullPath)!
        if let queryItems = self.getString(params: params) {
            urlComponent.queryItems = queryItems
        }
        let url = urlComponent.url!
        request = URLRequest(url: url)
        
        request?.httpMethod = api.method
        
        
        let task = URLSession.shared.dataTask(with: request!) { data, response, error in
            
            if error != nil {
                failure(error)
            }else {
                do {
                    if let jsonData = data {
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                        DispatchQueue.main.async(execute: {
                            success(parsedData, data)
                        })
                    }
                } catch {
                    failure(error)
                }
            }
        }
        task.resume()
    }
    
    private func getString(params:[String:Any]?) -> [URLQueryItem]? {
        guard let parameters = params else { return nil }
        var data = [URLQueryItem]()
        for(key, value) in parameters {
            data.append(URLQueryItem(name: key, value: value as? String))
        }
        return data
    }
}

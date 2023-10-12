//
//  Router.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import Foundation

protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : String { get }
    func handle(responseObj : Data) -> AnyObject?
    func isLoaderNeeded() -> Bool
}

extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        var params = [String : Any]()
        let newContainer = zip(self,values)
        
        for (key,element) in newContainer {
            params[key.rawValue] = element
        }
        
        return params
        
    }
}

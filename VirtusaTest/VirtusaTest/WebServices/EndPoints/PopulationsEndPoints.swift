//
//  PopulationsEndPoints.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import Foundation

enum PopulationsEndPoints {
    case getData(drilldowns: String, measures: String)
}

extension PopulationsEndPoints: Router {
    var route: String {
        return APIPaths.data
    }
    
    var baseURL: String {
        return APIPaths.baseURL
    }
    
    var parameters: OptionalDictionary {
        //Switch to handle multi case but right now we have only one case so we could direct return Parameters for data
        switch self {
            case .getData(let drilldowns, let measures):
                return Parameters.data.map(values: [drilldowns, measures])
        }
        
    }
    
    var method: String {
        //Switch to handle multi case but right now we have only one case so we could direct return GET
        switch self {
            default:
                return "GET"
        }
        
    }
    
    func isLoaderNeeded() -> Bool {
        //Switch to handle multi case but right now we have only one case so we can direct return true
        return true
    }
    
    
}

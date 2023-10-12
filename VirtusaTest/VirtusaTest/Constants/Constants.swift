//
//  Constants.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

struct Constants {
    static let populationCell = "PopulationCell"
}

typealias OptionalDictionary = [String : Any]?

internal struct APIPaths {
    static let baseURL  = "https://datausa.io/api/"
    static let data     = "data"
}

enum Keys: String {
    case drilldowns     = "drilldowns"
    case measures       = "measures"
}

struct Parameters {
    static let data: [Keys] = [.drilldowns, .measures]
}

enum Response {
    case success(AnyObject?)
    case failure(Int,String)
}

enum ResponseCodes : Int {
    case noResponse         = 0
    case success            = 200
    case successCreated     = 201
    case badRequest         = 400
    case sessionExpired     = 401
    case notFound           = 404
    case notRegigsterWithFB = 403
    case noInternet         = 13
    case userVerified       = 1
    
}

enum ResponseMessages {
    
    static func somethingWentWrong() -> String {
        return "Something went wrong. Please try again after sometime."
    }
    
    static func serverNotReachable() -> String {
        return "Unable to connect to server. Please try again after sometime"
    }
    
    static func noInternetConnection() -> String {
        return "Please check your internet connection"
    }
}

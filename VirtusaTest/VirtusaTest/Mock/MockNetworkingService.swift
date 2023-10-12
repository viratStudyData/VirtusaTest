//
//  MockNetworkingService.swift
//  VirtusaTest
//
//  Created by Virat on 10/12/23.
//

import Foundation

class MockNetworkingService: NetworkingService {
    func fetchRequest(withApi api: Router, success: @escaping HttpClientSuccess, failure: @escaping HttpClientFailure) {
        let jsonString = """
            "data":[{"ID Nation":"01000US","Nation":"United States","ID Year":2020,"Year":"2020","Population":326569308,"Slug Nation":"united-states"}]
        """
        
        if let data = jsonString.data(using: .utf8) {
            success(data, nil)
        } else {
            let error = NSError(domain: "MockNetworkingServiceErrorDomain", code: -1, userInfo: nil)
            failure(error)
        }
    }
}

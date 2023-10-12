//
//  APIHandler.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import Foundation

extension PopulationsEndPoints {
    //Switch to handle multi case but right now we have only one case so we Could direct return PopulationDataModel
    func handle(responseObj: Data) -> AnyObject? {
        switch self {
        default:
            guard let response = try? JSONDecoder().decode(PopulationDataModel.self, from: responseObj) else { return nil }
            return response as AnyObject
        }
    }
    
}

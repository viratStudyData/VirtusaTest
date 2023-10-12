//
//  PopulationDataModel.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import Foundation

struct PopulationDataModel: Codable {
    var data: [Record]?
}

struct Record: Codable {
    var Year: String?
    var Population: Int64?
}

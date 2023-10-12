//
//  PopulationCell.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import UIKit

class PopulationCell: UITableViewCell {
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var population: UILabel!
    
    func loadData(data: Record) {
        year.text = data.Year ?? "2023"
        population.text = String(describing: data.Population ?? 0)
    }
}

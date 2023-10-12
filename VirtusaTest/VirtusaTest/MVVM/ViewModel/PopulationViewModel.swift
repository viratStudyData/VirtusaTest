//
//  ViewModel.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import UIKit

class PopulationViewModel: NSObject {
    var data = [Record]()
    func getData(completion:@escaping (Bool) -> Void) {
        APIManager.shared.fetchRequest(with: PopulationsEndPoints.getData(drilldowns: "Nation", measures: "Population"), completion: { [weak self] response in
            guard let sSelf = self else { return }
            switch response {
                case .success(let res):
                    guard let response = res as? PopulationDataModel, let data = response.data else { return }
                    sSelf.data = data
                    let flag = data.isEmpty
                    completion(flag)
                    
                case.failure(_, let message):
                    completion(true)
                    print(message)
            }
        })
    }
}
extension PopulationViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.populationCell, for: indexPath) as? PopulationCell {
            cell.loadData(data: data[indexPath.row])
            cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.9179885787, green: 0.9179885787, blue: 0.9179885787, alpha: 1) : .white
            
            return cell
        }
        return UITableViewCell()
    }
}

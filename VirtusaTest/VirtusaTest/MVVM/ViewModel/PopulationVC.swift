//
//  PopulationVC.swift
//  VirtusaTest
//
//  Created by Virat on 10/11/23.
//

import UIKit

class PopulationVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    var dataModel = PopulationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        loadData()
    }
    
    private func config(){
        tableView?.dataSource = dataModel
    }
    
    private func loadData() {
        dataModel.getData { [weak self] isDataEmpty in
            guard let sSelf = self else { return }
            
            DispatchQueue.main.async {
                sSelf.lblNoRecord.isHidden = !isDataEmpty
                sSelf.tableView.isHidden = isDataEmpty
            }
            
            if !isDataEmpty {
                DispatchQueue.main.async {
                    sSelf.tableView.reloadData()
                }
            }
        }
    }
}

//
//  CustomersVC.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 22/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import UIKit

class CustomersVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var table: UITableView!
    
    var dataSource: TableDataSource<Customer>!
    var customers = [Customer]()
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        dataSource = TableDataSource<Customer>(with: customers) { (customer, indexPath) -> (UITableViewCell) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = customer.name
            cell.detailTextLabel?.text = "ID: \(customer.userId)"
            return cell
        }
        dataSource.setData(items: customers)
        table.tableFooterView = UIView()
        table.dataSource = dataSource
    }
    
}

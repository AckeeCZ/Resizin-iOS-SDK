//
//  ViewController.swift
//  ResizinExample
//
//  Created by Jakub Olejník on 14/02/2018.
//  Copyright © 2018 Ackee. All rights reserved.
//

import UIKit
import Resizin
import SnapKit
import ACKategories
import AlamofireImage

final class ViewController: UIViewController, UITableViewDataSource {
    private weak var tableView: UITableView!
    
    private let settingsData = [
        (title: "Crop mode: .fill", settings: ResizinSettings(size: Constants.resizinSize, cropMode: .fill), contentMode: UIView.ContentMode.scaleAspectFill),
        (title: "Crop mode: .fit", settings: ResizinSettings(size: Constants.resizinSize, cropMode: .fit), contentMode: .scaleAspectFit)
    ]
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let tableView = UITableView()
        tableView.allowsSelection = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Resizin Example"
        
        tableView.dataSource = self
    }
    
    // MARK: UITableView data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TitleImageCell = tableView.dequeueCell(for: indexPath)
        let cellData = settingsData[indexPath.row]
        let imageURL = ResizinManager.shared.url(for: Constants.imageKey, settings: cellData.settings)
        cell.titleLabel.text = cellData.title
        cell.imageView2.contentMode = cellData.contentMode
        cell.imageView2.af.setImage(withURL: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
}

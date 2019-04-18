//
//  ViewController.swift
//  Facebook
//
//  Created by Seoyoung on 11/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class FBViewController: FBBaseViewController{
    
    typealias RowModel = [String: String]
    
    fileprivate var user: FBUser {
        get {
            return FBUser(name: "seoyoung", education: "CMU")
        }
    }
    
    fileprivate var tableViewDataSource: [[String: Any]] {
        get {
            return TableKeys.populate(user)
        }
    }
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(FBTableViewCell.self, forCellReuseIdentifier: FBTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Facebook"
        navigationController?.navigationBar.barTintColor = Specs.color.tint
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Set layout for tableView.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
    }
    
    fileprivate func rows(at section: Int) -> [Any] {
        return tableViewDataSource[section][TableKeys.rows] as! [Any]
    }
    
    fileprivate func title(at section: Int) -> String? {
        return tableViewDataSource[section][TableKeys.section] as? String
    }
    
    fileprivate func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }
}

extension FBViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelForRow = rowModel(at: indexPath)
        var cell = UITableViewCell()
        
        guard let title = modelForRow[TableKeys.title] else {
            return cell
        }
        
        if title == user.name {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FBTableViewCell.identifier, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if let imageName = modelForRow[TableKeys.imageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != TableKeys.logout {
            cell.imageView?.image = UIImage(named: Specs.imageList.placeholder)
        }
        
        if title == user.name {
            cell.detailTextLabel?.text = modelForRow[TableKeys.subTitle]
        }
         
        return cell
    }
}

extension FBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[TableKeys.title] else {
            return 0.0
        }
        
        if title == user.name {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[TableKeys.title] else {
            return
        }
        
        if title == TableKeys.seeMore || title == TableKeys.addFavorites {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
        } else if title == TableKeys.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
}

//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Seoyoung on 22/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    fileprivate var resItems: [(title: String, description: String, pubDate: String)]?
    fileprivate var cellState: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        feedParser.parserFeed(feedURL: feedURL) { [weak self] resItems in
            self?.resItems = resItems
            self?.cellState = Array(repeating: .collapsed, count: resItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
            
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resItems = resItems else{
            return 0
        }
        return resItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        if let item = resItems?[indexPath.row] {
            (cell.titleLabel.text, cell.descriptionLabel.text, cell.dateLabel.text) = (item.title, item.description, item.pubDate)
            if let cellState = cellState?[indexPath.row] {
                cell.descriptionLabel.numberOfLines = cellState == .expanded ? 0:4
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = cell.descriptionLabel.numberOfLines == 4 ? 0:4
        cellState?[indexPath.row] = cell.descriptionLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
    }

}

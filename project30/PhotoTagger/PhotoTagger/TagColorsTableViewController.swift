//
//  TagColorsTableViewController.swift
//  PhotoTagger
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

struct TagColorTableData {
    var label: String
    var color: UIColor?
}

class TagColorsTableViewController: UITableViewController {
    var data: [TagColorTableData]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else {
            return 0
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else {
            fatalError("No cell data available")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagOrColorCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].label
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let data = data else {
            fatalError("No cell data available")
        }
        
        guard let color = data[indexPath.row].color else {
            cell.textLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
            return
        }
        
        var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let threshold = CGFloat(105)
        let bgDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
        
        let textColor = (255 - bgDelta < threshold) ? UIColor.black : UIColor.white;
        cell.textLabel?.textColor = textColor
        cell.backgroundColor = color
        
    }
}

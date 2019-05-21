//
//  TagColorsViewController.swift
//  PhotoTagger
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class TagColorsViewController: UIViewController {
    
    var tags: [String]?
    var colors: [PhotoColor]?
    var tableViewController: TagColorsTableViewController!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableData()
    }
    
    @IBAction func tagsColorsSegmentedControlChanged(_ sender: Any) {
        setupTableData()
    }
    
    func setupTableData() {
        if segmentedControl.selectedSegmentIndex == 0 {
            if let tags = tags {
                tableViewController?.data = tags.map {
                    TagColorTableData(label: $0, color: nil)
                }
            } else {
                tableViewController?.data = [TagColorTableData(label: "No tags were fetched.", color: nil)]
            }
        } else {
            if let colors = colors {
                tableViewController?.data = colors.map({ (photoColor: PhotoColor) -> TagColorTableData in
                    let uicolor = UIColor(red: CGFloat(photoColor.red!) / 255, green: CGFloat(photoColor.green!) / 255, blue: CGFloat(photoColor.blue!) / 255, alpha: 1.0)
                    return TagColorTableData(label: photoColor.colorName!, color: uicolor)
                })
            } else {
                tableViewController?.data = [TagColorTableData(label: "No colors were fetched.", color: nil)]
            }
        }
        tableViewController?.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DataTable" {
            guard let controller = segue.destination as? TagColorsTableViewController else {
                fatalError("Storyboard mis-configuration.")
            }
        }
    }
    
}

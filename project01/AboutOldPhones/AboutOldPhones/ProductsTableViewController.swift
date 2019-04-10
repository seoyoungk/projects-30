//
//  ProductsTableViewController.swift
//  AboutOldPhones
//
//  Created by Seoyoung on 10/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var productlist = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1 = ["image": "image-cell1", "info": "1907 Wall Set", "full screen": "phone-fullscreen1"]
        let img2 = ["image": "image-cell2", "info": "1921 Dial Phone", "full screen": "phone-fullscreen2"]
        let img3 = ["image": "image-cell3", "info": "1937 Desk Set", "full screen": "phone-fullscreen3"]
        let img4 = ["image": "image-cell4", "info": "11984 Moto Portable", "full screen": "phone-fullscreen4"]
        
        productlist = [img1, img2, img3, img4]
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return productlist.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productlist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductsTableViewCell
        
        let dicTemp = productlist[indexPath.row]
        cell.imgView.image = UIImage(named: dicTemp["image"]!)
        cell.infoLabel.text = dicTemp["info"]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            (segue.destination as! DetailViewController).detaildata = dicTemp[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}

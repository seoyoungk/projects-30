//
//  DetailViewController.swift
//  AboutOldPhones
//
//  Created by Seoyoung on 09/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var detaildata = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = detaildata["info"]
        imgView.image = UIImage(named: detaildata["full screen"]!)
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        print("ADD TO CART successfully! :)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DetailViewController.swift
//  CandySearch
//
//  Created by Seoyoung on 22/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var candyImageVIew: UIImageView!
    
    var detailCandy: Candy? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel, let candyImageView = candyImageVIew {
                detailDescriptionLabel.text = detailCandy.name
                candyImageView.image = UIImage(named: detailCandy.name)
                title = detailCandy.category
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
}

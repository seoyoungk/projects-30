//
//  ArtistListViewController.swift
//  Artistry
//
//  Created by Seoyoung on 20/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ArtistListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let artists = Artist.artistFromBundle()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        // cell row 자동 확장
//        self.tableView.estimatedRowHeight = 165
//        self.tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedArtist = artists[indexPath.row]
        }
    }

}

extension ArtistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
        
        let artist = artists[indexPath.row]
        
        cell.artistImageView.image = artist.image
        cell.nameLabel.text = artist.name
        cell.bioLabel.text = artist.bio
        cell.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
        
        cell.nameLabel.backgroundColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
        cell.nameLabel.textColor = UIColor.white
        cell.nameLabel.textAlignment = .center
        cell.selectionStyle = .none
        
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
    
    
}

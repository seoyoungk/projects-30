//
//  PhotoTableViewController.swift
//  ClassicPhotosCell
//
//  Created by Seoyoung on 24/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import CoreImage

let dataSourceURL = URL(string:"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")

class PhotoTableViewController: UITableViewController {
    var photos = [PhotoRecord]()
    let pendingOperation = PendingOperation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        self.title = "Classic Photos"
        fetchPhotoDetails()
    }
    
    fileprivate func fetchPhotoDetails() {
        let request = URLRequest(url: dataSourceURL!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
            if let error = error {
                let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: false)
                return
            }
            if let data = data {
                do {
                    if let datasourceDictionary = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(rawValue: 0), format: nil) as? [String: AnyObject] {
                        for (name, url) in datasourceDictionary {
                            if let url = URL(string: url as! String) {
                                let photoRecord = PhotoRecord(name: name, url: url)
                                self.photos.append(photoRecord)
                            }
                        }
                        self.tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.domain)
                }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
    fileprivate func startOperationsForPhotoRecord(photoDetails: PhotoRecord, indexPath: IndexPath){
        switch (photoDetails.state) {
        case .New:
            startDownloadForRecord(photoDetails: photoDetails, indexPath: indexPath)
        case .Downloaded:
            startFiltrationForRecord(photoDetails: photoDetails, indexPath: indexPath)
        default:
            NSLog("Do Nothing")
        }
    }
    
    fileprivate func startDownloadForRecord(photoDetails: PhotoRecord, indexPath: IndexPath){
        if let _ = pendingOperation.downloadInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperation.downloadInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        pendingOperation.downloadInProgress[indexPath] = downloader
        pendingOperation.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func startFiltrationForRecord(photoDetails: PhotoRecord, indexPath: IndexPath){
        if let _ = pendingOperation.filtrationsInProgress[indexPath]{
            return
        }
        
        let filterer = ImageFiltration(photoRecord: photoDetails)
        filterer.completionBlock = {
            if filterer.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperation.filtrationsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        pendingOperation.filtrationsInProgress[indexPath] = filterer
        pendingOperation.filtrationQueue.addOperation(filterer)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: .gray)
            cell.accessoryView = indicator
        }
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        let photoDetails = photos[indexPath.row]
        
        cell.textLabel?.text = photoDetails.name
        cell.imageView?.image = photoDetails.image
        
        switch (photoDetails.state){
        case .Filtered:
            indicator.stopAnimating()
        case .Failed:
            indicator.stopAnimating()
            cell.textLabel?.text = "Failed to load"
        case .New, .Downloaded:
            indicator.startAnimating()
            if (!tableView.isDragging && !tableView.isDecelerating) {
                self.startOperationsForPhotoRecord(photoDetails: photoDetails, indexPath: indexPath)
            }
        }
        return cell
    }
    // scrolling
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        suspendAllOperations()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImageForOnCells()
            resumeAllOperations()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImageForOnCells()
        resumeAllOperations()
    }
    
    fileprivate func suspendAllOperations() {
        pendingOperation.downloadQueue.isSuspended = true
        pendingOperation.filtrationQueue.isSuspended = true
    }
    
    fileprivate func resumeAllOperations() {
        pendingOperation.downloadQueue.isSuspended = false
        pendingOperation.filtrationQueue.isSuspended = false
    }
    fileprivate func loadImageForOnCells() {
        if let pathArray = tableView.indexPathsForVisibleRows {
        
            var allPendingOperations = Set(pendingOperation.downloadInProgress.keys)
            allPendingOperations = allPendingOperations.union(pendingOperation.filtrationsInProgress.keys)
            
            // get cells should cancel operations
            var toBeCancelled = allPendingOperations
            let visiblePaths = Set(pathArray)
            toBeCancelled.subtract(visiblePaths)
            
            // get cells should be started as new
            var toBeStarted = visiblePaths
            toBeStarted.subtract(allPendingOperations)
            
            // cancel download and filter operations for unvisible cells
            for indexPath in toBeCancelled {
                if let pendingDownload = pendingOperation.downloadInProgress[indexPath] {
                    pendingDownload.cancel()
                }
                pendingOperation.downloadInProgress.removeValue(forKey: indexPath)
                if let pendingFiltration = pendingOperation.filtrationsInProgress[indexPath] {
                    pendingFiltration.cancel()
                }
                pendingOperation.filtrationsInProgress.removeValue(forKey: indexPath)
            }
            
            // start operation for new visible cells
            for indexPath in toBeStarted {
                let recordToProcess = self.photos[indexPath.row]
                startOperationsForPhotoRecord(photoDetails: recordToProcess, indexPath: indexPath)
            }
        }
    }
    
}

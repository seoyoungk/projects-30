//
//  ViewController.swift
//  MusicAlbum
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scroller: HorizontalScrollerView!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // Private Variables
    fileprivate var allAlbums = [Album]()
    fileprivate var currentAlbumData: [AlbumData]?
    fileprivate var currentAlbumIndex = 0
    
    // use a stack to push and pop operation for the undo option
    fileprivate var undoStack: [(Album, Int)] = []
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func setUI() {
            navigationController?.navigationBar.isTranslucent = false
        }
        
        func setData() {
            currentAlbumIndex = 0
            allAlbums = LibraryAPI.sharedInstance.getAlbums()
        }
        
        func setComponents() {
            dataTable.backgroundView = nil
            loadPreviousState()
            scroller.delegate = self
            scroller.dataSource = self
            reloadScroller()
            scroller.scrollToView(at: currentAlbumIndex)
            
            let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action:Selector.undoAction)
            undoButton.isEnabled = false;
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action:nil)
            let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target:self, action:Selector.deleteAlbum)
            let toolbarButtonItems = [undoButton, space, trashButton]
            toolbar.setItems(toolbarButtonItems, animated: true)
        }
        
        setUI()
        setData()
        setComponents()
        showDataForAlbum(at: currentAlbumIndex)
        
        NotificationCenter.default.addObserver(self, selector:Selector.saveCurrentState, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func showDataForAlbum(at index: Int) {
        if index < allAlbums.count && index > -1 {
            let album = allAlbums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        
        dataTable.reloadData()
    }
    
    // **** Memento Pattern ****
    @objc func saveCurrentState() {
        // When the user leaves the app and then comes back again, he wants it to be in the exact same state
        // save the currently displayed album.
        // use NSUserDefaults.
        UserDefaults.standard.set(currentAlbumIndex, forKey: Constants.indexRestorationKey)
        LibraryAPI.sharedInstance.saveAlbums()
    }
    
    func loadPreviousState() {
        currentAlbumIndex = UserDefaults.standard.integer(forKey: Constants.indexRestorationKey)
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    // Scroller Related
    func reloadScroller() {
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex >= allAlbums.count {
            currentAlbumIndex = allAlbums.count - 1
        }
        scroller.reload()
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    func addAlbumAtIndex(_ album: Album,index: Int) {
        LibraryAPI.sharedInstance.addAlbum(album, index: index)
        currentAlbumIndex = index
        reloadScroller()
    }
    
    @objc func deleteAlbum() {
        // get album
        let deletedAlbum : Album = allAlbums[currentAlbumIndex]
        // add to stack
        let undoAction = (deletedAlbum, currentAlbumIndex)
        undoStack.insert(undoAction, at: 0)
        // use library API to delete the album
        LibraryAPI.sharedInstance.deleteAlbum(currentAlbumIndex)
        reloadScroller()
        // enable the undo button
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        let undoButton : UIBarButtonItem = barButtonItems[0]
        undoButton.isEnabled = true
        // disable trashbutton when no albums left
        if (allAlbums.count == 0) {
            let trashButton : UIBarButtonItem = barButtonItems[2]
            trashButton.isEnabled = false
        }
    }
    
    @objc func undoAction() {
        let barButtonItems = toolbar.items! as [UIBarButtonItem]
        // pop to undo the last one
        if undoStack.count > 0 {
            let (deletedAlbum, index) = undoStack.remove(at: 0)
            addAlbumAtIndex(deletedAlbum, index: index)
        }
        // disable undo button when no albums left
        if undoStack.count == 0 {
            let undoButton : UIBarButtonItem = barButtonItems[0]
            undoButton.isEnabled = false
        }
        // enable the trashButton as there must be at least one album there
        let trashButton : UIBarButtonItem = barButtonItems[2]
        trashButton.isEnabled = true
    }
}

// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumData = currentAlbumData {
            return albumData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        if let albumData = currentAlbumData {
            cell.textLabel?.text = albumData[indexPath.row].title
            cell.detailTextLabel?.text = albumData[indexPath.row].value
        }
        return cell
    }
}

// HorizontalScrollerDataSource
extension ViewController: HorizontalScrollerDataSource {
    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        return allAlbums.count
    }
    
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
        let album = allAlbums[index]
        
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverURL)
        
        if currentAlbumIndex == index {
            albumView.highlightAlbum(true)
        } else {
            albumView.highlightAlbum(false)
        }
        return albumView
    }
}

//  HorizontalScrollerDelegate
extension ViewController: HorizontalScrollerDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {
        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)
        
        currentAlbumIndex = index
        
        let albumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        albumView.highlightAlbum(true)
        showDataForAlbum(at: currentAlbumIndex)
    }
}

// Constants
fileprivate enum Constants {
    static let cellIdentifier = "Cell"
    static let indexRestorationKey = "currentAlbumIndex"
}

fileprivate extension Selector {
    static let undoAction = #selector(ViewController.undoAction)
    static let deleteAlbum = #selector(ViewController.deleteAlbum)
    static let saveCurrentState = #selector(ViewController.saveCurrentState)
}

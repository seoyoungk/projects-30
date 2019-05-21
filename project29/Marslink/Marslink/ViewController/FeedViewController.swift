//
//  FeedViewController.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import IGListKit


class FeedViewController: UIViewController {
    fileprivate let loader = JournalEntryLoader()
    fileprivate let pathfinder = Pathfinder()
    fileprivate let wxScanner = WxScanner()
    fileprivate let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.black
        return view
    }()
    
    fileprivate lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func setupUI() {
            view.addSubview(collectionView)
        }
        
        func setupDataSource() {
            loader.loadLatest()
            
            adapter.collectionView = collectionView
            adapter.dataSource = self
            
            pathfinder.delegate = self
            pathfinder.connect()
        }
        
        setupUI()
        setupDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}


extension FeedViewController: IGListAdapterDataSource {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items: [IGListDiffable] = [wxScanner.currentWeather]
        items += loader.entries as [IGListDiffable]
        items += pathfinder.messages as [IGListDiffable]
        
        return items.sorted(by: {(left: Any, right: Any) -> Bool in
            if let left = left as? DateSortable,
                let right = right as? DateSortable {
                return left.date > right.date
            }
            return false
        })
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Message {
            return MessageSectionController()
        } else if object is Weather {
            return WeatherSectionController()
        } else {
            return JournalSectionController()
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension FeedViewController: PathfinderDelegate {
    func pathfinderDidUpdateMessages(pathfinder: Pathfinder) {
        adapter.performUpdates(animated: true)
    }
}

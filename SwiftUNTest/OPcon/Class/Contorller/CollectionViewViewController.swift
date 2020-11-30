//
//  CollectionViewViewController.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/16.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class CollectionViewViewController: UIViewController {
    
    fileprivate var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUpCollectionView()
        
    }
    
    func setUpCollectionView() {
        let layout = CollectionViewLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 5
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = UIColor.blue
//        self.collectionView.register(UINib.init(nibName: "WaterfallCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WaterfallCell")
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "WaterfallCell");
        self.collectionView.register(WaterfallReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WaterfallReusableView")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension CollectionViewViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallCell", for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusedView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WaterfallReusableView", for: indexPath)
        reusedView.backgroundColor = UIColor.green
        
        return reusedView
    }
}
 
extension CollectionViewViewController : WaterfallLayoutDelegate{
    func itemHeightForIndexPath(indexpath: IndexPath) -> CGFloat? {
        return CGFloat(arc4random() % UInt32(100)) + 10.0
    }
}


class WaterfallReusableView: UICollectionReusableView {
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



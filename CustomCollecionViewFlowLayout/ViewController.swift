//
//  ViewController.swift
//  CustomCollecionViewFlowLayout
//
//  Created by amitan on 2015/06/20.
//  Copyright (c) 2015年 amitan. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController{

    private let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let  layout = self.collectionView?.collectionViewLayout as? CustomCollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            
            layout.maxColumn = 3
            layout.cellPattern.append(sideLength: 2,heightLength: 2,column: 0,row: 0)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 2,row: 0)
            layout.cellPattern.append(sideLength: 1,heightLength: 2,column: 2,row: 1)
            layout.cellPattern.append(sideLength: 1,heightLength: 2,column: 0,row: 2)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 1,row: 2)
            layout.cellPattern.append(sideLength: 2,heightLength: 1,column: 1,row: 3)
        }
        
        collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        var mainLabel = UILabel(frame: cell.frame)
        
        mainLabel.text = "\(indexPath.section)-\(indexPath.item)"
        mainLabel.textAlignment = .Center
        mainLabel.backgroundColor = UIColor.blueColor()
        cell.backgroundView = mainLabel
        cell.clipsToBounds = true
        cell.addSubview(mainLabel)
        return cell
    }
}

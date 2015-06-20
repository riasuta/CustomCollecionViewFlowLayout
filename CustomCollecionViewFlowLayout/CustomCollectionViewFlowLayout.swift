//
//  CustomCollectionViewFlowLayout.swift
//  CustomCollecionViewFlowLayout
//
//  Created by amitan on 2015/06/20.
//  Copyright (c) 2015年 amitan. All rights reserved.
//

import UIKit

public class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private static let kMaxRow = 3
    
    var maxColumn = kMaxRow
    var cellPattern:[(sideLength: CGFloat, heightLength:CGFloat, column:CGFloat, row:CGFloat)] = []
    
    private var sectionCells = [[CGRect]]()
    private var contentSize = CGSizeZero
    
    override public func prepareLayout() {
        super.prepareLayout()
        sectionCells = [[CGRect]]()
        
        if let collectionView = self.collectionView {
            contentSize = CGSize(width: collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right, height: 0)
            let smallCellSideLength: CGFloat = (contentSize.width - super.sectionInset.left - super.sectionInset.right - (super.minimumInteritemSpacing * (CGFloat(maxColumn) - 1.0))) / CGFloat(maxColumn)
            
            for section in (0..<collectionView.numberOfSections()) {
                var cells = [CGRect]()
                var numberOfCellsInSection = collectionView.numberOfItemsInSection(section);
                var height = contentSize.height
                
                for i in (0..<numberOfCellsInSection) {
                    let position = i  % (numberOfCellsInSection)
                    let cellPosition = position % cellPattern.count
                    let cell = cellPattern[cellPosition]
                    let x = (cell.column * (smallCellSideLength + super.minimumInteritemSpacing)) + super.sectionInset.left
                    let y = (cell.row * (smallCellSideLength + super.minimumLineSpacing)) + contentSize.height + super.sectionInset.top
                    let cellwidth = (cell.sideLength * smallCellSideLength) + ((cell.sideLength-1) * super.minimumInteritemSpacing)
                    let cellheight = (cell.heightLength * smallCellSideLength) + ((cell.heightLength-1) * super.minimumLineSpacing)
                    
                    let cellRect = CGRectMake(x, y, cellwidth, cellheight)
                    cells.append(cellRect)
                    
                    if (height < cellRect.origin.y + cellRect.height) {
                        height = cellRect.origin.y + cellRect.height
                    }
                }
                contentSize = CGSize(width: contentSize.width, height: height)
                sectionCells.append(cells)
            }
        }
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        if let collectionView = self.collectionView {
            for (var i = 0 ;i<collectionView.numberOfSections(); i++) {
                var sectionIndexPath = NSIndexPath(forItem: 0, inSection: i)
                
                var numberOfCellsInSection = collectionView.numberOfItemsInSection(i);
                for (var j = 0; j<numberOfCellsInSection; j++) {
                    let indexPath = NSIndexPath(forRow:j, inSection:i)
                    if let attributes = layoutAttributesForItemAtIndexPath(indexPath) {
                        if (CGRectIntersectsRect(rect, attributes.frame)) {
                            layoutAttributes.append(attributes)
                        }
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes.frame = sectionCells[indexPath.section][indexPath.row]
        return attributes
    }
    
    override public func collectionViewContentSize() -> CGSize {
        return contentSize
    }
}

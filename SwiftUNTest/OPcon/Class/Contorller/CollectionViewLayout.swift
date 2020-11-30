//
//  CollectionViewLayout.swift
//  TestSwift
//
//  Created by open-roc on 2019/8/16.
//  Copyright © 2019  open-roc. All rights reserved.
//

import UIKit
protocol WaterfallLayoutDelegate {
    func itemHeightForIndexPath(indexpath : IndexPath) -> CGFloat?
}
class CollectionViewLayout: UICollectionViewLayout {
    //行间距
    var minimumLineSpacing: CGFloat = 0.0{
        didSet{
            //设置item的宽度
            self.setUpItemWidth()
        }
    }
    
    //列间距
    var minimumInteritemSpacing: CGFloat = 0.0{
        didSet{
            //设置item的宽度
            self.setUpItemWidth()
        }
    }
    var scrollDirection: UICollectionView.ScrollDirection = .vertical // default is UICollectionViewScrollDirectionVertical
    fileprivate var item_w : CGFloat = 0//item宽度
    //内边距
    var sectionInset: UIEdgeInsets = UIEdgeInsets.zero{
        didSet{
            //设置item的宽度
            self.setUpItemWidth()
        }
    }
    //列数，默认2
    var columnsNum = 2{
        didSet{
            //设置列高
            self.columnsHeightArray.removeAll()
            for _ in 0...self.columnsNum{
                //如果数量不对则全部设置为0
                self.columnsHeightArray.append(0)
            }
            //设置item的宽度
            self.setUpItemWidth()
        }
    }
    
    var delegate : WaterfallLayoutDelegate?
    
    fileprivate var attrArray : Array<UICollectionViewLayoutAttributes> = Array<UICollectionViewLayoutAttributes>()//属性数组
    fileprivate var columnsHeightArray : Array<CGFloat> = [0,0]//每列的高度
    
    //设置每一个item的属性
    func setAttrs() {
        guard let secNum = self.collectionView?.numberOfSections else {
            return
        }
        for i in 0...secNum-1{
            for i in 0...self.columnsNum - 1{
                self.columnsHeightArray[i] = self.getLongValue()
            }
            self.attrArray.append(self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(row: 0, section: i))!)
            guard let itemsNum = self.collectionView?.numberOfItems(inSection: i) else {
                return
            }
            for j in 0...itemsNum - 1{
                self.attrArray.append(self.layoutAttributesForItem(at: IndexPath.init(row: j, section: i))!)
            }
        }
    }
    
    //获取最短列的索引
    func getShortesIndex() -> Int {
        var index = 0
        for i in 0...self.columnsNum - 1{
            if self.columnsHeightArray[index] > self.columnsHeightArray[i]{
                index = i
            }
        }
        return index
    }
    
    //获取最长列的值
    func getLongValue() -> CGFloat {
        var value : CGFloat = 0
        for i in 0...self.columnsNum - 1{
            if value < self.columnsHeightArray[i]{
                value = self.columnsHeightArray[i]
            }
        }
        return value
    }
    
    //设置每列的宽度
    func setUpItemWidth(){
        guard let collectionWidth = self.collectionView?.frame.size.width else {
            return
        }
        self.item_w = (collectionWidth - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat((self.columnsNum - 1))) / CGFloat(self.columnsNum)
    }
    
    override var collectionViewContentSize: CGSize{
        get{
            return CGSize.init(width: 0, height: self.getLongValue() + self.sectionInset.top + self.sectionInset.bottom)
        }
    }
    
    override func prepare() {
        super.prepare()
        self.setUpItemWidth()
        self.setAttrs()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let shortesIndex = self.getShortesIndex()
        let item_x = self.sectionInset.left + (self.item_w + self.minimumInteritemSpacing) * CGFloat(shortesIndex)
        let item_y = self.columnsHeightArray[shortesIndex] + self.sectionInset.top
        let item_h = self.delegate?.itemHeightForIndexPath(indexpath: indexPath) ?? 0
        attr.frame = CGRect.init(x: item_x, y: item_y , width: self.item_w, height: item_h)
        
        //更新列高数组
        self.columnsHeightArray[shortesIndex] += (item_h + self.minimumLineSpacing)
        return attr
    }
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: elementKind, with: indexPath)
        let header_x : CGFloat = self.sectionInset.left
        let header_y : CGFloat = self.columnsHeightArray[0] + self.minimumLineSpacing + self.sectionInset.top
        let header_w = self.item_w * CGFloat(self.columnsNum) + self.minimumInteritemSpacing * CGFloat(self.columnsNum - 1)
        let header_h : CGFloat = 40
        attr.frame = CGRect.init(x: header_x, y: header_y, width: header_w, height: header_h)
        for i in 0...self.columnsNum - 1{
            self.columnsHeightArray[i] += (header_h + self.minimumLineSpacing)
        }
        return attr
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrArray
    }
}

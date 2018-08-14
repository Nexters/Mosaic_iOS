//
//  HomeViewController.swift
//  Mosaic_iOS
//
//  Created by Zedd on 2018. 7. 28..
//  Copyright © 2018년 Zedd. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255 ,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    static func create() -> HomeViewController? {
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: classNameToString) as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    
        self.setupNavigation()
        
        self.setupSearchBar()
        
        self.view.backgroundColor = UIColor(hex:"#ff573dz")
        
    
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex:"#ff573dz")
     
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    

    }
    @objc
    func setupNavigation() {
        let logo = UIImage(named: "icLogotype")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func setupSearchBar() {
        self.searchView.backgroundColor = UIColor(hex: "#e62f12")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchBarViewDidTap))
        self.searchView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func searchBarViewDidTap() {
        // FIXME: - 검색화면viwe
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.layer.borderColor = UIColor.blue.cgColor
        self.collectionView.layer.borderWidth = 0.5
        let xib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        self.collectionView.register(xib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.backgroundColor = .clear
    }
    
    @IBAction func myPageButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
  
    @IBAction func filterButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func writeButtonDidTap(_ sender: UIButton) {
        
    }
    
    var colors: [UIColor]  = [
        UIColor(red: 237, green: 37, blue: 78),
        UIColor(red: 249, green: 220, blue: 92),
        UIColor(red: 194, green: 234, blue: 189),
        UIColor(red: 1, green: 25, blue: 54),
        UIColor(red: 255, green: 184, blue: 209)
    ]
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.configure()
        
        return cell
    }
    
}

open class CardsCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: - Layout configuration
    
    public var itemSize: CGSize = CGSize(width: 300, height: 300) {
        didSet{
            invalidateLayout()
        }
    }
    
    public var spacing: CGFloat = 10.0 {
        didSet{
            invalidateLayout()
        }
    }
    
    public var maximumVisibleItems: Int = 4 {
        didSet{
            invalidateLayout()
        }
    }
    
    // MARK: UICollectionViewLayout
    
    override open var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    override open var collectionViewContentSize: CGSize {
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width: collectionView.bounds.width * itemsCount,
                      height: collectionView.bounds.height)
    }
    
    override open func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let totalItemsCount = collectionView.numberOfItems(inSection: 0)
        
        let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)
        
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        
        let visibleIndices = stride(from: minVisibleIndex, to: maxVisibleIndex, by: 1)
        
        let attributes: [UICollectionViewLayoutAttributes] = visibleIndices.map { index in
            let indexPath = IndexPath(item: index, section: 0)
            return computeLayoutAttributesForItem(indexPath: indexPath,
                                                  minVisibleIndex: minVisibleIndex,
                                                  contentCenterX: contentCenterX,
                                                  deltaOffset: CGFloat(deltaOffset),
                                                  percentageDeltaOffset: percentageDeltaOffset)
        }
        
        return attributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let minVisibleIndex = Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width)
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        return computeLayoutAttributesForItem(indexPath: indexPath,
                                              minVisibleIndex: minVisibleIndex,
                                              contentCenterX: contentCenterX,
                                              deltaOffset: CGFloat(deltaOffset),
                                              percentageDeltaOffset: percentageDeltaOffset)
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


// MARK: - Layout computations

fileprivate extension CardsCollectionViewLayout {
    
    private func scale(at index: Int) -> CGFloat {
        let translatedCoefficient = CGFloat(index) - CGFloat(self.maximumVisibleItems) / 2
        return CGFloat(pow(0.95, translatedCoefficient))
    }
    
    private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
        var rawScale = visibleIndex < maximumVisibleItems ? scale(at: visibleIndex) : 1.0
        
        if visibleIndex != 0 {
            let previousScale = scale(at: visibleIndex - 1)
            let delta = (previousScale - rawScale) * percentageOffset
            rawScale += delta
        }
        return CGAffineTransform(scaleX: rawScale, y: rawScale)
    }
    
    fileprivate func computeLayoutAttributesForItem(indexPath: IndexPath,
                                                    minVisibleIndex: Int,
                                                    contentCenterX: CGFloat,
                                                    deltaOffset: CGFloat,
                                                    percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
        let visibleIndex = indexPath.row - minVisibleIndex
        attributes.size = itemSize
        let midY = self.collectionView.bounds.midY
        attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                    y: midY + spacing * CGFloat(visibleIndex))
        attributes.zIndex = maximumVisibleItems - visibleIndex
        
        attributes.transform = transform(atCurrentVisibleIndex: visibleIndex,
                                         percentageOffset: percentageDeltaOffset)
        switch visibleIndex {
        case 0:
            attributes.center.x -= deltaOffset
            break
        case 1..<maximumVisibleItems:
            attributes.center.x -= spacing * percentageDeltaOffset
            attributes.center.y -= spacing * percentageDeltaOffset
            
            
            if visibleIndex == maximumVisibleItems - 1 {
                attributes.alpha = percentageDeltaOffset
            }
            break
        default:
            attributes.alpha = 0
            break
        }
        return attributes
    }
}


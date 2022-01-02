//
//  HomeBannerTVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit


class HomeBannerTVCell: UITableViewCell {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var homeBannerTVCellVM: HomeBannerTVCellVM? {
        didSet {
            onMain { [weak self] in
                self?.bannerCollectionView.reloadData()
            }
        }
    }
    
    var timer = Timer()
    var counter = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
    }
    
    /// scroll cells programatically by interval time
    @objc func changeImage() {
        guard (homeBannerTVCellVM?.imgsURLs?.count ?? 0 > 0) else { return }
        if counter < ((homeBannerTVCellVM?.imgsURLs?.count ?? 0) - 2) {
            let index = IndexPath.init(item: counter, section: 0)
            onMain {[weak self] in
                self?.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        } else {
            counter = 1
            let index = IndexPath.init(item: counter, section: 0)
            onMain {[weak self] in
                self?.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }
        counter += 1
    }
    
}

// MARK: - Conform bannerCollectionView protocols
extension HomeBannerTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let noOfCells = homeBannerTVCellVM?.imgsURLs?.count ?? 0
        noOfCells == 0 ? collectionView.setEmptyView() : collectionView.setEmptyView(nil)
        return noOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCell.identifier, for: indexPath) as? BannerCVCell ?? BannerCVCell()
        cell.imgUrl = URL(string: homeBannerTVCellVM?.imgsURLs?[indexPath.item] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
}

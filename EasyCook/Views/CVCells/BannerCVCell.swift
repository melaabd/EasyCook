//
//  BannerCVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit
import SDWebImage

class BannerCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImgView: UIImageView!
    
    var imgUrl:URL? {
        didSet {
            updateBanner()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bannerImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    
    func updateBanner() {
        bannerImgView?.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "coverPlaceholder"), completed: nil)
    }
}

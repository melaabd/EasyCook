//
//  RecipeTVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit
import SDWebImage

class RecipeTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var recipeImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    var recipeCellVM: RecipeCellVM? {
        didSet {
            updateCellData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
        recipeImgView.layer.cornerRadius = 8
        userImgView.layer.cornerRadius = userImgView.frame.height / 2
        
        
    }

    private func updateCellData() {
        titleLbl.text = recipeCellVM?.title
        userNameLbl.text = recipeCellVM?.userName
        
        userImgView?.sd_setImage(with: recipeCellVM?.userPic, placeholderImage: UIImage(named: "userPlaceholder"), completed: nil)
        recipeImgView?.sd_setImage(with: recipeCellVM?.imageURL, placeholderImage: UIImage(named: "coverPlaceholder"), completed: nil)
    }

}

//
//  RecipeStepTVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit
import SDWebImage

class RecipeStepTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var recipeImgView: UIImageView!
    
    
    var recipeStepCellVM: RecipeStepCellVM? {
        didSet {
            updateCellInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        recipeImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        descTxtView.dataDetectorTypes = .all
    }
    
    /// assign the data in cell
    private func updateCellInfo() {
        descTxtView.text = recipeStepCellVM?.desc
        recipeImgView.sd_setImage(with: recipeStepCellVM?.imageURL,placeholderImage: UIImage(named: "coverPlaceholder"), completed: nil)
        descTxtView.isHidden = !(recipeStepCellVM?.desc?.containAnyWord() ?? false)
        recipeImgView.isHidden = (recipeStepCellVM?.imageURL == nil)
    }

}

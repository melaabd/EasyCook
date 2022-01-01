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
    @IBOutlet weak var descLbl: UILabel!
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
    }

    private func updateCellInfo() {
        descLbl.text = recipeStepCellVM?.desc
        recipeImgView.sd_setImage(with: recipeStepCellVM?.imageURL,placeholderImage: UIImage(named: "coverPlaceholder"), completed: nil)
        descLbl.isHidden = !(recipeStepCellVM?.desc?.containAnyWord() ?? false)
        recipeImgView.isHidden = (recipeStepCellVM?.imageURL == nil)
    }

}

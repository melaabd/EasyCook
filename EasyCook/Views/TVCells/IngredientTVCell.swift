//
//  IngredientTVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/30/21.
//

import UIKit

class IngredientTVCell: UITableViewCell {
    
    
    @IBOutlet weak var itemIndexLbl: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var removeItemBtn: UIButton!
    
    var removeCompletion:CompletionVoid?
    var ingredientCellVM:IngredientCellVM? {
        didSet {
            updateCellInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemView.layer.cornerRadius = (itemView.bounds.height < 50) ? (itemView.bounds.height / 2) : 20
        removeItemBtn.layer.cornerRadius = removeItemBtn.bounds.height / 2
    }
    
    /// assign data in the cell
    private func updateCellInfo() {
        itemIndexLbl.text = "\((ingredientCellVM?.index ?? 0) + 1)."
        itemTitleLbl.text = ingredientCellVM?.title ?? ""
    }
    
    @IBAction func removeItemAction(_ sender: Any) {
        removeCompletion?()
    }
    
}

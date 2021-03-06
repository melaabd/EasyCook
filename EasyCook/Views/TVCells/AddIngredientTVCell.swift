//
//  AddIngredientTVCell.swift
//  EasyCook
//
//  Created by melaabd on 12/28/21.
//

import UIKit

class AddIngredientTVCell: UITableViewCell {
    
    @IBOutlet weak var addItemContainerView: UIView!
    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemTxtField: UITextField!
    
    @IBOutlet weak var findRecipesView: UIView!
    @IBOutlet weak var addIngredientView: UIView!
    
    var ingredientsCount = 0 {
        didSet {
            updateUIComponents()
        }
    }
    
    var isSearching:Bool = false
    var findRecipesCompletion:CompletionVoid?
    var addItemCompletion:((_ title:String)->Void)?
    var sizeChangeCompletion:CompletionVoid?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemTxtField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemView.layer.cornerRadius = itemView.bounds.height / 2
        itemView.layer.borderColor = Theme.prime.color.cgColor
        itemView.layer.borderWidth = 1.5
        
        findRecipesView.layer.cornerRadius = 4
        itemTxtField.becomeFirstResponder()
    }
    
    /// update uicomponent visability depending on the state
    private func updateUIComponents() {
        indexLbl.text = "\(ingredientsCount + 1)."
        if ingredientsCount == 0 {
            isSearching = false
        }
        addItemContainerView.isHidden = (isSearching || ingredientsCount > 2)
        addIngredientView.isHidden = ((!isSearching && ingredientsCount < 3) || ingredientsCount > 2)
        findRecipesView.isHidden = (isSearching || ingredientsCount == 0)
        sizeChangeCompletion?()
    }
    
    /// keybord return key action
    /// - Parameter text: textField text
    func returnKeyPressed(text: String) {
        ingredientsCount += 1
        itemTxtField.text = ""
        addItemCompletion?(text)
        updateUIComponents()
    }
    
    /// find recipes that have the ingredient action
    @IBAction func findRecipesAction(_ sender: Any) {
        isSearching = true
        findRecipesCompletion?()
        updateUIComponents()
    }
    
    
    /// add one more ingredient action
    @IBAction func addIngredientAction(_ sender: Any) {
        isSearching = false
        updateUIComponents()
    }
}


// MARK: - Conform with UITextFieldDelegate
extension AddIngredientTVCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text, text.containAnyWord(), ingredientsCount < 3 else {
            textField.text = ""
            return true
        }
        returnKeyPressed(text: text)
        return true
    }
}

//
//  RecipeStepCellVM.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import Foundation

class RecipeStepCellVM {
    
    var desc:String?
    var imageURL: URL?
    
    /// initialize the cell view model by passing a Step Model
    /// - Parameter step: Step
    required init(_ step: Step) {
        
        desc = step.stepDescription
        if (step.imageUrls?.count ?? 0) > 0, let stepImg = step.imageUrls?.first {
            imageURL = URL(string: stepImg)
        }
    }
}

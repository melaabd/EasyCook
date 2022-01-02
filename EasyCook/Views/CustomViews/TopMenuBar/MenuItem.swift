//
//  MenuItem.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

class MenuItem {
    
    var id = 0
    var titleName: String = ""
    var tabWidth: CGFloat = 0
    private var font:UIFont?
    
    /// initialize the item with id and title and default font for width calculation
    /// - Parameters:
    ///   - id: Int
    ///   - titleName: `String`
    ///   - font: `UIFont`
    required init(id: Int, titleName: String, font:UIFont = .systemFont(ofSize: 14, weight: .medium)) {
        self.id = id
        self.titleName = titleName
        self.tabWidth = getTextWidthWith(content: titleName)
        self.font = font
    }
    
    /// calculate width of title
    /// - Parameter content: String
    /// - Returns: the width `CGFloat`
    private func getTextWidthWith(content:String?) -> CGFloat {
        guard let txt = content, txt != "" else { return 0}
        let mutableAttributed = NSMutableAttributedString()
        let attributed: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : font ?? .systemFont(ofSize: 14, weight: .medium)]
        mutableAttributed.append(NSAttributedString(string: txt, attributes: attributed))
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 1
        label.attributedText = mutableAttributed
        let newSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 40))
        return newSize.width
    }
    
}

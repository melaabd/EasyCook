//
//  MenuCell.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var menuItem: MenuItem? {
        didSet {
            updateCellInfo()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var cBackgroundView:UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubViews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cBackgroundView.layer.cornerRadius = 4
        
    }
    
    /// assign data in the cell
    fileprivate func updateCellInfo() {
        titleLabel.text = menuItem?.titleName
    }
    
    /// detect when user select an item
    override var isSelected: Bool {
        didSet {
            self.cBackgroundView.backgroundColor = self.isSelected ? Theme.prime.color : .clear
        }
    }
    
    /// add sub views to the cell and set constraints
    func configureSubViews() {
        
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        titleLabel.layoutIfNeeded()
        
        contentView.insertSubview(cBackgroundView, at: 0)
        cBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        cBackgroundView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        cBackgroundView.layoutIfNeeded()
        
        layoutIfNeeded()
    }
}

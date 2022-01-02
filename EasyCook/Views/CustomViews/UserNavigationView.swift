//
//  UserNavigationView.swift
//  EasyCook
//
//  Created by melaabd on 12/31/21.
//

import UIKit
import SDWebImage

class UserNavigationView: UIView {
    
    var imageURL: URL?
    var userName: String?
    
    lazy var userImage: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var userNameLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.numberOfLines = 1
        nameLbl.font = .boldSystemFont(ofSize: 18)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        return nameLbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(userName:String, imgUrl:URL?, width: CGFloat = UIScreen.main.bounds.size.width - 40, height: CGFloat =  40) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.imageURL = imgUrl
        self.userName = userName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// add userImage to the view and add constrants
        addSubview(userImage)
        userImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        userImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        userImage.layer.cornerRadius =  userImage.frame.height / 2
        userImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImage.sd_setImage(with: imageURL,placeholderImage:UIImage(named: "userPlaceholder"), completed: nil)
        
        /// add userNameLbl to the view and add constrants
        addSubview(userNameLbl)
        userNameLbl.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10).isActive = true
        userNameLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userNameLbl.text = userName
    }
    
}


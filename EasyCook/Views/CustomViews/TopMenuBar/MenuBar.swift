//
//  MenuBar.swift
//  EasyCook
//
//  Created by melaabd on 12/26/21.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func cellSelectedAt(index:Int)
}

class MenuBar: UIView {
    
    var collectionView: UICollectionView!
    var items: [MenuItem]?
    var selectedIndexID = 0
    weak var delegate:MenuBarDelegate?
    var itemsSpace:CGFloat {
        return calculateSpace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(menuItems:[MenuItem], delegate:MenuBarDelegate, width: CGFloat = UIScreen.main.bounds.size.width, height: CGFloat =  40, backGroundColor:UIColor = Theme.backG.color) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.items = menuItems
        backgroundColor = backGroundColor
        self.delegate = delegate
        setupMenuBar()
    }
    
    private func setupMenuBar() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        collectionView.layoutIfNeeded()
        layoutIfNeeded()
        
        updateCellSelection(index: IndexPath(item: 0, section: 0))
    }
    
    
    private func calculateSpace() -> CGFloat {
        guard let items = items else { return 0 }
        let width:CGFloat = items.map({$0.tabWidth}).reduce(0, +)
        let space = (collectionView.frame.width - width) / CGFloat(items.count)
        if space > 20 {
            return space
        } else {
            return 20
        }
    }
    
    private func updateCellSelection(index: IndexPath) {
        onMain { [weak self] in
            self?.collectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        }
        selectedIndexID = items?[index.item].id ?? 0
        if let delegate = self.delegate {
            delegate.cellSelectedAt(index: selectedIndexID)
        }
    }
    
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell ?? MenuCell()
        guard let item = items?[indexPath.row] else { return cell }
        cell.menuItem = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCellSelection(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (items?[indexPath.row].tabWidth ?? 0) + itemsSpace, height: 30)
        
    }
    
}

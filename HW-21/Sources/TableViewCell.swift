//
//  TableViewCell.swift
//  HW-21
//
//  Created by Илья on 29.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let idetifier = "TableViewCell"
    var cards: Card?
    
    // MARK: - Elements
    
    var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 1
        return imageView
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = 270
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let typeCard: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = 270
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: TableViewCell.idetifier)
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        addSubview(cardImage)
        addSubview(name)
        addSubview(typeCard)
       
    }
    
    private func setupLayout() {
        
        cardImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.height.equalTo(180)
            make.width.equalTo(110)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.centerX.equalTo(contentView)
            make.left.equalTo(cardImage.snp.right).offset(15)
        }
        
        typeCard.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(20)
            make.left.equalTo(cardImage.snp.right).offset(15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        cardImage.image = nil
        typeCard.text = nil
    }
      
    func configure(model: Card) {
        name.text = model.name
        typeCard.text = model.type
    }
}


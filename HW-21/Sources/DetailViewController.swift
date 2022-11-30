//
//  DetailViewController.swift
//  HW-21
//
//  Created by Илья on 29.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var card: [Card]?
    
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
        label.textAlignment = .center
        label.numberOfLines = 3
        label.preferredMaxLayoutWidth = 250
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let typeCard: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.preferredMaxLayoutWidth = 250
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let rarity: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.preferredMaxLayoutWidth = 250
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 7
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = 350
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarhy()
        setupLayout()
        view.backgroundColor = .darkGray
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        view.addSubview(cardImage)
        view.addSubview(name)
        view.addSubview(typeCard)
        view.addSubview(rarity)
        view.addSubview(text)
    }
    
    private func setupLayout() {
        
        cardImage.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(350)
            make.width.equalTo(270)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(cardImage.snp.bottom).offset(15)
            make.centerX.equalTo(view)
            
        }
        
        typeCard.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        rarity.snp.makeConstraints { make in
            make.top.equalTo(typeCard.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        text.snp.makeConstraints { make in
            make.top.equalTo(rarity.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    func showCard(model: Card?) {
        name.text = "Имя карты:\n \( model?.name ?? "")"
        typeCard.text = "Тип карты:\n \(model?.type ?? "")"
        rarity.text = "Редкость карты:\n \(model?.rarity ?? "")"
        text.text = "Описание карты:\n \(model?.text ?? "")"
        cardImage.sd_setImage(with: URL(string: model?.imageUrl ?? ""), placeholderImage: UIImage(named: "nofoto"))
    }
}


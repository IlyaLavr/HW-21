//
//  DetailViewController.swift
//  HW-21
//
//  Created by Илья on 29.11.2022.
//

import UIKit

protocol SetUpViewDetail {
    func setUpView(_ card: Card)
}

class DetailViewController: UIViewController {
    
    var yyy: Card?
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let typeCard: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let rarity: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        showCard(model: yyy)
        view.backgroundColor = .black

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
        name.text = "Имя карты: \( model?.name ?? "")"
        typeCard.text = "Тип карты: \(model?.type ?? "")"
        rarity.text = "Редкость карты: \(model?.rarity ?? "")"
        text.text = "Описание карты: \n \(model?.text ?? "")"
        cardImage.sd_setImage(with: URL(string: yyy?.imageUrl ?? ""))
    }
}
//
extension DetailViewController: SetUpViewDetail {

    func setUpView(_ card: Card) {
        self.yyy = card
        name.text = card.name
        typeCard.text = card.text
        text.text = card.text
        yyy?.name = card.name
        yyy?.text = card.text
        yyy?.rarity = card.rarity
        yyy?.type = card.type
    }
}


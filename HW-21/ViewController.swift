//
//  ViewController.swift
//  HW-21
//
//  Created by Илья on 29.11.2022.
//

import UIKit
import Alamofire
import SnapKit
import SDWebImage

class ViewController: UIViewController {
    
    var cards: [Card] = []
    var urlString = "https://api.magicthegathering.io/v1/cards"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idetifier)
        return tableView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Нвзвание карты"
        textField.isHighlighted = true
        textField.layer.cornerRadius = 17
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Поиск", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(findCards), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.fetchCharacter(url: self.urlString)
        }
        setupHierarhy()
        setupLayout()
    }
    
    
    private func setupHierarhy() {
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(1)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(40)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(textField.snp.right).offset(10)
            make.height.equalTo(70)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(2)
            make.right.equalTo(button.snp.right).offset(-70)
            make.height.equalTo(70)
        }
    }
    
    func fetchCharacter(url: String) {
        let request = AF.request(urlString)
        request.responseDecodable(of: CardInfo.self) { (data) in
            print(data)
            guard let card = data.value else { return }
            let cards = card.cards
            self.cards = cards.filterDuplicate{ $0.name }
            self.tableView.reloadData()
        }
    }
    
    @objc func findCards() {
        let cardFind = textField.text
        if cardFind != "" {
            
            // TODO: Исправить это
            DispatchQueue.main.async {
                self.urlString = "https://api.magicthegathering.io/v1/cards?name=\(cardFind ?? "")"
                self.fetchCharacter(url: self.urlString)
            }
            self.textField.text = ""
        } else {
            urlString = "https://api.magicthegathering.io/v1/cards"
            fetchCharacter(url: urlString)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idetifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let model = cards[indexPath.row]
        
        // TODO:  Перенести в отдельную функцию
        cell.name.text = "Имя карты: \(model.name)"
        cell.typeCard.text = "Тип карты: \(model.type ?? "")"
        cell.cardImage.sd_setImage(with: URL(string: model.imageUrl ?? ""), placeholderImage: UIImage(systemName: "pencil.circle.fill"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let card = cards[indexPath.row]
        let viewcontroller = DetailViewController()
        if let sheet = viewcontroller.sheetPresentationController {
            sheet.detents = [.large()]
        }
        
        // TODO:  Настроить одну из моделей
        viewcontroller.showCard(model: card)
        viewcontroller.setUpView(card)
        present(viewcontroller, animated: true)
    }
}

extension Array
{
    func filterDuplicate<T:Hashable>(_ keyValue:(Element)->T) -> [Element]
    {
        var uniqueKeys = Set<T>()
        return filter{uniqueKeys.insert(keyValue($0)).inserted}
    }
    
    func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
    {
        return filterDuplicate{"\(keyValue($0))"}
    }
}



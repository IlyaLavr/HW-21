//
//  Model.swift
//  HW-21
//
//  Created by Илья on 29.11.2022.
//

import Foundation

struct CardInfo: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    var name: String
    var type: String?
    var rarity: String?
    var text: String?
    let imageUrl: String?
}

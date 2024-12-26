//
//  BrawlerList.swift
//  Brawl Stars Wiki
//
//  Created by admin on 04/03/24.
//

import Foundation

// MARK: - BrawlWiki
struct BrawlWiki: Codable {
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let id, avatarID: Int?
    let name, hash, path, fankit: String?
    let released: Bool?
    let version: Int?
    let link: String?
    let imageURL, imageUrl2, imageUrl3: String?
    let listClass: Class?
    let rarity: Rarity?
//    let unlock: JSONNull?
    let description, descriptionHTML: String?
    let starPowers, gadgets: [Gadget]?
//    let videos: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case id
        case avatarID
        case name, hash, path, fankit, released, version, link
        case imageURL
        case imageUrl2, imageUrl3
        case listClass
        case rarity, description
        case descriptionHTML
        case starPowers, gadgets
//        case unlock, videos
    }
}

// MARK: - Gadget
struct Gadget: Codable {
    let id: Int?
    let name, path: String?
    let version: Int?
    let description, descriptionHTML: String?
    let imageURL: String?
    let released: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, path, version, description
        case descriptionHTML
        case imageURL
        case released
    }
}

// MARK: - Class
struct Class: Codable {
    let id: Int?
    let name: ClassName?
}

enum ClassName: String, Codable {
    case artillery = "Artillery"
    case assassin = "Assassin"
    case controller = "Controller"
    case damageDealer = "Damage Dealer"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
    case unknown = "Unknown"
}

// MARK: - Rarity
struct Rarity: Codable {
    let id: Int?
    let name: RarityName?
    let color: Color?
}

enum Color: String, Codable {
    case b9Eaff = "#b9eaff"
    case d850Ff = "#d850ff"
    case fe5E72 = "#fe5e72"
    case fff11E = "#fff11e"
    case the5Ab3Ff = "#5ab3ff"
    case the68Fd58 = "#68fd58"
}

enum RarityName: String, Codable {
    case common = "Common"
    case epic = "Epic"
    case legendary = "Legendary"
    case mythic = "Mythic"
    case rare = "Rare"
    case superRare = "Super Rare"
}

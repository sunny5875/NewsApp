//DetailModel.swift

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [NaverNewsItem]
}

// MARK: - Item
struct NaverNewsItem: Codable {
    let title: String
    let originallink: String
    let link: String
    let itemDescription, pubDate: String

    enum CodingKeys: String, CodingKey {
        case title, originallink, link
        case itemDescription = "description"
        case pubDate
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        self.originallink = try container.decode(String.self, forKey: .originallink)
        self.link = try container.decode(String.self, forKey: .link)
        self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        self.pubDate = try container.decode(String.self, forKey: .pubDate)
    }
}

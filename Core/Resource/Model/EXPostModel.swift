//
//  EXPostModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import CoreImage
typealias PostResponse = [EXPostModel]
typealias CodingKeys = (String, CodingKey)
struct EXPostModel: Codable {
    let id: String?
    let title, content, publishedAt, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, content
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(default value: DefaultPost) {
        self.id = value.id
        self.title = value.content
        self.content = value.content
        self.publishedAt = value.publishedAt
        self.createdAt = value.createdAt
        self.updatedAt = value.createdAt
    }

    init(from decoder: Decoder) throws {
        // MARK: Handle Id
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try? values.decodeIfPresent(String.self, forKey: .id)
        let idInt = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.id = idString ?? idInt?.string

        self.title = try? values.decodeIfPresent(String.self, forKey: .title)
        self.content = try? values.decodeIfPresent(String.self, forKey: .content)
        self.publishedAt = try? values.decodeIfPresent(String.self, forKey: .publishedAt)
        self.createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}

struct DefaultPost {
    let id: String? = nil
    let title: String? = nil
    let content: String? = nil
    let publishedAt: String? = nil
    let createdAt: String? = nil
    let updatedAt: String? = nil
}

public extension Int {
    var string: String {
        return String(self)
    }
}

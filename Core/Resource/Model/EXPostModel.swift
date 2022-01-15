//
//  EXPostModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import CoreImage
typealias PostResponse = [EXPostModel]

struct EXPostModel: Codable {
    let id: Int?
    let title, content, publishedAt, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, content
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(default value: DefaultPost) {
        self.id = value.id.orEmpty.int
        self.title = value.content
        self.content = value.content
        self.publishedAt = value.publishedAt
        self.createdAt = value.createdAt
        self.updatedAt = value.createdAt
    }
}

struct DefaultPost {
    let id: String? = nil
    let title: String = ""
    let content: String = ""
    let publishedAt: String = ""
    let createdAt: String = ""
    let updatedAt: String = ""
}

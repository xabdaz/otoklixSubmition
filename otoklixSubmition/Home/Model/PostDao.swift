//
//  PostDao.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
public struct PostDao {
    let model: EXPostModel
    func getContent() -> String? {
        return model.content
    }
}

//
//  DetailDao.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
public struct DetailDao {
    let model: EXPostModel
    func getContent() -> String? {
        return model.content
    }
}

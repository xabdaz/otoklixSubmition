//
//  MoreOptionsType.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit

struct MoreOptionsModel {
    let icon: UIImage?
    let title: String
}
enum MoreOptionsType {
    case delete(_ options: MoreOptionsModel = MoreOptionsModel(icon: nil, title: "Delete"))
    case edit(_ options: MoreOptionsModel = MoreOptionsModel(icon: nil, title: "Edit"))
    case read(_ options: MoreOptionsModel = MoreOptionsModel(icon: nil, title: "Edit"))

    var model: MoreOptionsModel {
        switch self {
        case let .delete(model):
            return model
        case let .edit(model):
            return model
        case let .read(model):
            return model
        }
    }
}

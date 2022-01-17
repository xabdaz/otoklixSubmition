//
//  CrudType.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation
public enum CrudType {
    case CREATE(Any)
    case EDIT(Any)
    case DELETE(Any)

    var value: Any {
        switch self {
        case let .CREATE(model):
            return model
        case let .DELETE(model):
            return model
        case let .EDIT(model):
            return model
        }
    }
}

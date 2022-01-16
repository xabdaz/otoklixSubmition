//
//  EXViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import Foundation
import RxSwift
open class EXViewModel: NSObject {
    let didFinishCoordinator = PublishSubject<Void>()
    let stateNotifView = PublishSubject<NotifStateView>()
}
public enum NotifStateView {
    case alert(message: String)
}

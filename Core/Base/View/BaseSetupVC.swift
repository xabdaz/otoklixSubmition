//
//  BaseSetupVC.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
public protocol BaseSetupVC: AnyObject {
    func setupUI()
    func setupOutPutBindings()
    func setupInputBindings()
    func setupState()
}

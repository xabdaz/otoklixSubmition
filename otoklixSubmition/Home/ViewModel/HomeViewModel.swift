//
//  HomeViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import RxSwift
import RxCocoa

public class HomeViewModel: EXViewModel {
    let outTableData = BehaviorRelay<[PostDao]>(value: [])
}

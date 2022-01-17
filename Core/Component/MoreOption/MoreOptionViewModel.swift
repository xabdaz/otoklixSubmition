//
//  MoreOptionViewModel.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import RxCocoa
import RxSwift

class MoreOptionsViewModel: EXViewModel {
    private let disposeBag = DisposeBag()
    //input
    let didItemSelected = PublishRelay<MoreOptionsType>()
    
    //output
    let titleAppBarViewData = BehaviorRelay<String>(value: "")
    
    //Varibale Support
    var isSelected = false
    
    let optionsViewData = BehaviorRelay<[MoreOptionsType]>(value: [])
    
    init(title: String = "Lainnya", options: [MoreOptionsType]) {
        self.optionsViewData.accept(options)
        self.titleAppBarViewData.accept(title)
        super.init()
        setupBindings()
    }
}
extension MoreOptionsViewModel {
    private func setupBindings() {
        didItemSelected
            .subscribe(onNext: { [weak self] _ in
                self?.isSelected = true
            }).disposed(by: self.disposeBag)
    }
}

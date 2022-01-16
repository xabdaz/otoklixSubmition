//
//  EXTableView.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import UIKit
import RxSwift
import RxCocoa

open class EXTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setupView() {
        sectionHeaderHeight = UITableView.automaticDimension
        sectionFooterHeight = 0.001 // zero cannot implemented by swift
        rowHeight = UITableView.automaticDimension
        separatorStyle = .none
    }

    public func reloadSectionWithoutAnimation(section: Int) {
        UIView.setAnimationsEnabled(false)
        self.beginUpdates()
        self.reloadSections(IndexSet(integer: section), with: .none)
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }

    func setWrapContent(contraint: NSLayoutConstraint, disposable: DisposeBag) {
        rx.observe(CGSize.self, #keyPath(UITableView.contentSize))
            .mainThreadAsync()
            .bind { [weak contraint] size in
                guard let height = size?.height else { return }
                contraint?.constant = height
            }.disposed(by: disposable)
    }

    func setWrap(contraint: NSLayoutConstraint) -> Observable<CGFloat> {
        return rx.observe(CGSize.self, #keyPath(UITableView.contentSize))
            .mainThreadAsync().flatMap { size -> Observable<CGFloat> in
                guard let height = size?.height else { return .never() }
                return .just(height)
            }
    }
    
}

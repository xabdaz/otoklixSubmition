//
//  EXViewControllerSheet.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import FittedSheets

class EXViewControllerSheet: UIViewController {
    private let disposeBag = DisposeBag()
    var safeAreaInsets: UIEdgeInsets {
        var inserts = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            inserts = UIApplication.shared.keyWindow?.safeAreaInsets ?? inserts
        }
        inserts.top = max(inserts.top, 20)
        return inserts
    }
    private let STATUS_BAR_HEIGHT: CGFloat = 20
    private let SPACE_SHEET_HEIGHT: CGFloat = 20
    private let BUZZLE_HEIGHT: CGFloat = 24
    
    private var safeArea: UIEdgeInsets {
        var inserts = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            inserts = UIApplication.shared.keyWindow?.safeAreaInsets ?? inserts
        }
        inserts.top = max(inserts.top, STATUS_BAR_HEIGHT)
        return inserts
    }
    
    private var maxHeight: CGFloat {
        let safeAreaSize = UIScreen.main.bounds.height - safeArea.top - safeArea.bottom
        return  safeAreaSize - SPACE_SHEET_HEIGHT - BUZZLE_HEIGHT
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EXViewControllerSheet {
    
    @available(*, deprecated, message: "Please use new method using rx")
    func setWrapContent(
        containerView: UIView,
        targetView: UIView?,
        _ keyPath: String? = nil,
        _ othersViewInContainer: [UIView] = [],
        _ disposable: DisposeBag,
        _ callback: @escaping (CGFloat) -> Void = { _ in }
    ) {
        viewBoundChangedObserver(view: containerView)
        
        guard let targetView = targetView, let keyPath = keyPath else { return }
        viewContentSizeChangedObserver(
            targetView: targetView,
            keyPath, othersViewInContainer,
            disposable,
            callback
        )
    }
    
    func setWrapContent(
        containerView: UIView,
        targetView: UIView?,
        _ keyPath: String? = nil,
        _ othersViewInContainer: [UIView] = []
    ) -> Observable<CGFloat> {
        viewBoundChangedObserver(view: containerView)
        
        guard let targetView = targetView, let keyPath = keyPath else { return .just(0) }
        return viewContentSizeChangedObserver(
            targetView: targetView,
            keyPath,
            othersViewInContainer
        )
    }
    
    func setWrapContent(
        onView: UIView,
        targetView: UIView?,
        _ keyPath: String? = nil,
        _ othersViewInContainer: [UIView] = []
    ) -> Observable<CGFloat> {
        viewBoundChangedObserver(view: onView)
        
        guard let targetView = targetView, let keyPath = keyPath else { return .just(0) }
        return viewContentSizeChangedObserver(
            targetView: targetView,
            keyPath,
            othersViewInContainer
        )
    }
    
    func viewContentSizeChangedObserver(
        targetView: UIView,
        _ keyPath: String,
        _ othersViewInContainer: [UIView] = []
    ) -> Observable<CGFloat> {
        return targetView.rx.observe(CGSize.self, keyPath)
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .map({ [weak self] rect -> CGFloat in
                guard let height = rect?.height,
                      let `self` = self else { return 0 }
                var otherViewHeight: CGFloat = 0
                
                othersViewInContainer.forEach { childView in
                    otherViewHeight += childView.frame.height
                }
                
                let totalContentHeight = otherViewHeight + height
                
                if totalContentHeight > self.maxHeight {
                    let resultHeight = self.maxHeight - otherViewHeight
                    return resultHeight < 0 ? 0 : resultHeight
                } else {
                    return height
                }
            })
    }
    
    private func viewContentSizeChangedObserver(
        targetView: UIView,
        _ keyPath: String,
        _ othersViewInContainer: [UIView] = [],
        _ disposable: DisposeBag,
        _ callback: @escaping (CGFloat) -> Void = { _ in }
    ) {
        targetView.rx.observe(CGSize.self, keyPath)
            .bind(onNext: { [weak self] rect in
                guard let height = rect?.height,
                      let `self` = self else { return }
                var otherViewHeight: CGFloat = 0
                
                othersViewInContainer.forEach { childView in
                    otherViewHeight += childView.frame.height
                }
                
                let totalContentHeight = otherViewHeight + height
                
                if totalContentHeight > self.maxHeight {
                    callback(self.maxHeight - otherViewHeight)
                } else {
                    callback(height)
                }
            }).disposed(by: disposable)
    }
    
    func viewBoundChangedObserver(view: UIView) {
        view.rx.observe(CGRect.self, #keyPath(UIView.bounds))
            .debounce(.milliseconds(250), scheduler: MainScheduler.instance)
            .flatMap { rect -> Observable<CGFloat> in return .just(rect?.height ?? 0) }
            .bind(to: rx.heightSheet)
            .disposed(by: self.disposeBag)
    }
}

extension Reactive where Base: UIViewController {
    var heightSheet: Binder<CGFloat> {
        return Binder(self.base) { viewController, value in
            viewController.sheeted?.setSizes([.fixed(value)])
        }
    }
}

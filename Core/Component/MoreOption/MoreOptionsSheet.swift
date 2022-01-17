//
//  MoreOptionsSheet.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit


import UIKit
import RxSwift

class MoreOptionsSheet: EXViewControllerSheet {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: EXTableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    private let disposeBag = DisposeBag()
    let viewModel: MoreOptionsViewModel
    init(viewModel: MoreOptionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpInputBindings()
        setUpOutputBindings()
        setUpData()
    }

}

extension MoreOptionsSheet {
    func setUpState() {}
    
    func setUpUI() {
        OLWithIconCell.registerTo(tableView: tableView)
    }
    
    func setUpData() {
        
    }
    
    func setUpInputBindings() {
        tableView.rx.modelSelected(MoreOptionsType.self)
            .bind { [weak self] moreOption in
                self?.sheeted?.closeSheet {
                    self?.viewModel.didItemSelected.accept(moreOption)
                }
            }.disposed(by: self.disposeBag)
    }
    
    func setUpOutputBindings() {

        viewModel.optionsViewData
            .bind(to: tableView.rx.items(
                cellIdentifier: OLWithIconCell.identifier,
                cellType: OLWithIconCell.self
            )) { _, item, cell in
                cell.container.imageCell.image = item.model.icon
                cell.container.labelCell.text = item.model.title
            }.disposed(by: self.disposeBag)

        setWrapContent(
            containerView: self.view,
            targetView: tableView,
            #keyPath(UITableView.contentSize),
            [self.stackView]
        ).bind { [weak self] height in
            self?.tableViewHeight.constant = height
        }.disposed(by: self.disposeBag)
    }
    
}

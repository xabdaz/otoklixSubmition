//
//  HomeVC.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import UIKit
import RxSwift

class HomeVC: EXViewController {

    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: EXTableView!

    private let viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupInputBindings()
        self.setupOutPutBindings()
        self.setupState()

        self.viewModel.fatchData()

    }

}

extension HomeVC: BaseSetupVC {
    func setupUI() {
        PostCell.registerTo(tableView: self.tableView)
    }
    
    func setupOutPutBindings() {
        self.viewModel.outTableData
            .bind(to: self.tableView.rx.items(
                cellIdentifier: PostCell.identifier,
                cellType: PostCell.self
            )) { _, item, cell in
                cell.setContent(item: item)
            }.disposed(by: self.disposeBag)
    }
    
    func setupInputBindings() {
        self.tableView.rx.modelSelected(PostDao.self)
            .bind(to: self.viewModel.didSelectedItem)
            .disposed(by: self.disposeBag)
    }
    
    func setupState() {
    }
}

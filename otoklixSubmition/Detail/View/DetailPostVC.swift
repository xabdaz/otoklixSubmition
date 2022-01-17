//
//  DetailPostVC.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import UIKit
import RxSwift

class DetailPostVC: EXViewController {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
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

        self.viewModel.fetchData()
        // Do any additional setup after loading the view.
    }
    override func onFinishCoordinator() {
        self.viewModel.didFinishCoordinator.onNext(())
    }
}

extension DetailPostVC: BaseSetupVC {
    func setupUI() {
    }
    
    func setupOutPutBindings() {
        self.viewModel.outTitle
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)

        self.viewModel.outContent
            .bind { [weak self] text in
                let text = text.orEmpty
                DispatchQueue.main.async {
                    self?.contentLabel.attributedText = text.htmlToAttributedString
                }
            }.disposed(by: self.disposeBag)
//            .disposed(by: self.disposeBag)
    }
    
    func setupInputBindings() {
    }
    
    func setupState() {
    }

}

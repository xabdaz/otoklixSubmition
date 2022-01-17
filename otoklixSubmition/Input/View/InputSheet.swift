//
//  InputSheet.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 17/01/22.
//

import UIKit
import RxSwift

class InputSheet: EXViewControllerSheet {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!

    private let disposebag = DisposeBag()
    private let viewModel: InputViewModel
    init(viewModel: InputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupInputBindings()
        self.setupOutPutBindings()
        self.setupState()

        self.viewModel.fetchData()
    }

}

extension InputSheet: BaseSetupVC {
    func setupUI() {
    }

    func setupOutPutBindings() {
        self.viewModel.inOutTitle
            .bind(to: self.titleTextField.rx.text)
            .disposed(by: self.disposebag)

        self.viewModel.inOutContent
            .bind(to: self.contentTextView.rx.text)
            .disposed(by: self.disposebag)
    }

    func setupInputBindings() {
        self.titleTextField.rx.text
            .bind(to: self.viewModel.inOutTitle)
            .disposed(by: self.disposebag)

        self.contentTextView.rx.text
            .bind(to: self.viewModel.inOutContent)
            .disposed(by: self.disposebag)

        self.saveButton.rx.tap
            .bind(to: self.viewModel.didSavePressed)
            .disposed(by: self.disposebag)
    }

    func setupState() {
    }

}

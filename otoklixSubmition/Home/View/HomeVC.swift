//
//  HomeVC.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import UIKit
import MapKit

class HomeVC: EXViewController {
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
        let mock = MockupClient()
        mock.request(resource: "posts", method: .get, json: nil) { result in
            switch result {
                
            case .success(_):
                print("success")
            case .failure(_):
                print("error")
            }
        }
    }

}

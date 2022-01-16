//
//  HomeVC.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 15/01/22.
//

import UIKit
import MapKit

class HomeVC: EXViewController {

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

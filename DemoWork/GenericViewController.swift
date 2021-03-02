//
//  GenericViewController.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import UIKit

protocol ViewControllerProtocol {
    associatedtype ViewModelType
}

class GenericViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//
//  SignUpOptionViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/02.
//

import UIKit

class SignUpOptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//
//  ViewController.swift
//  TechEnglish
//
//  Created by KatsuyaTamai on 2025/02/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .systemBackground
    }
    
    func setupView() {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        view.addSubview(label)
    }


}


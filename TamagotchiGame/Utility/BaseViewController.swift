//
//  BaseViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    func setupUI() { }

    func bindViewModel() { }
}

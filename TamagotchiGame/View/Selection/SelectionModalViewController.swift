//
//  SelectionModalViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/22/25.
//

import UIKit

class SelectionModalViewController: BaseViewController {

    let mainView = SelectionModalView()
    
    override func loadView() {
        view = mainView
    }
    
    override func bindViewModel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

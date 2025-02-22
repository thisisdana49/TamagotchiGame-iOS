//
//  TamagotchiViewController.swift
//  TamagotchiGame
//
//  Created by 조다은 on 2/21/25.
//

import UIKit

class TamagotchiViewController: UIViewController {

    let mainView = TamagotchiView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

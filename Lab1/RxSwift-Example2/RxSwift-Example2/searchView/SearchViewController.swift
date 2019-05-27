//
//  SearchViewController.swift
//  RxSwift-Example2
//
//  Created by JETS Mobile Lab - 2 on 5/27/19.
//  Copyright © 2019 Sally Ahmed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       /* //after done
     searchTextField.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe( onNext: {[weak self] in
            self?.searchLabel.text = "We Are Searching for "
            self?.searchLabel.text?.append(contentsOf: (self?.searchTextField.text)!)
        })*/
      
        //auto compleat
        searchTextField.rx.controlEvent(UIControl.Event.editingChanged).asObservable()
            .throttle(2, scheduler: MainScheduler.asyncInstance).subscribe( onNext: {[weak self] in
            self?.searchLabel.text = "We Are Auto Searching for "
            self?.searchLabel.text?.append(contentsOf: (self?.searchTextField.text)!)
            print("edit")
        })
        
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

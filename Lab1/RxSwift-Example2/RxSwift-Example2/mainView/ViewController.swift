//
//  ViewController.swift
//  RxSwift-Example2
//
//  Created by Sally on 5/24/19.
//  Copyright © 2019 Sally Ahmed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController ,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var ThrottelBtn: UIButton!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    @IBOutlet weak var devounceBtn: UIButton!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let items = Observable.just(
//            (0..<20).map{ "Example \($0)" }
//        )
        
        onOffSwitch.rx.isOn.subscribe(onNext: { [weak self] isChanged in
            print(isChanged)
           //refresh layout
            self?.mainCollectionView.collectionViewLayout.invalidateLayout()
        }).disposed(by: disposeBag)
        
        
        ThrottelBtn.rx.tap.throttle(2, scheduler: MainScheduler.asyncInstance).subscribe(onNext: {
            (_) in print("Ttap")
        }).disposed(by: disposeBag)
        devounceBtn.rx.tap.debounce(2, scheduler: MainScheduler.asyncInstance).subscribe(onNext: {
            (_) in print("Dtap")
        }).disposed(by: disposeBag)
        
        
        
       let items = Observable.of(["Example 1","Example 2","Example 3", "Example 4" , "Example 5"])
        
        items.asObservable()
            .bind(to: self.self.mainCollectionView.rx.items(cellIdentifier: "imageCell", cellType: ImageCollectionViewCell.self))
            { (row , data , cell) in
                cell.cellLable.text = data}
            .disposed(by: disposeBag)
 
        
        self.mainCollectionView
            .rx
            .modelSelected(String.self)
            .subscribe(onNext: { [weak self] (value) in
            let alert = UIAlertController(title: "", message: value, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
   // add this line you can provide the cell size from delegate method
        mainCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if(onOffSwitch.isOn){
             let cellWidth = (width - 30) / 3 // compute your cell width
            let cellheight = (width - 30) / 5
            return CGSize(width: cellWidth, height: cellheight / 0.9)
        }else{
           let cellheight = (width - 30) / 5
            return CGSize(width: width, height: cellheight / 0.9)
        }
       
        
    }

}


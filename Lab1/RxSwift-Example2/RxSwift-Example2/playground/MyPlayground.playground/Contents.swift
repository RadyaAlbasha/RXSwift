import UIKit
import RxSwift
import RxCocoa
let disposeBag = DisposeBag()
let intDriver = Observable.of(1, 2, 3, 4, 5, 6)
    .asDriver(onErrorJustReturn: 1)
    .map { $0 + 1 }
    .filter { $0 < 5 }

intDriver.drive(onNext: { (value) in
    print(value)
}).disposed(by: disposeBag)

let numbers = Observable.of(0, 1, 2 , 3, 4, 5, 6)

numbers.scan([-1]) { lastSlice, newValue in
    return Array(lastSlice + [newValue])
    }.subscribe(onNext: { (value) in
        print(value)
    }).disposed(by: disposeBag)


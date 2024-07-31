//
//  OperatorViewController.swift
//  RxPractice
//
//  Created by 김상규 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class OperatorViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        justFunc()
        fromFunc()
        intervalFunc()
    }
    
    func justFunc() {
        Observable.just([3.14, "안녕하세요", 2002, UIView(), "iPhone16"])
            .subscribe { value in
                print("Next Value:", value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

    }

    func fromFunc() {
        Observable.from([3.14, "안녕하세요", 2002, UIView(), "iPhone16"])
            .subscribe { value in
                print("Next Value: ", value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }

    func intervalFunc() {
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(15)
            .subscribe { value in
                print("next: ", value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }

}

//
//  AddingNumberViewController.swift
//  RxPractice
//
//  Created by 김상규 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AddingNumberViewController: UIViewController {
    private let firstTextField = UITextField()
    private let secondTextField = UITextField()
    private let thirdTextField = UITextField()
    
    private let plusLabel = UILabel()
    private let divider = UIView()
    
    private let resultLabel = UILabel()
    
    // Observable
    private var num1 = 0
    private var num2 = 0
    private var num3 = 0
    
    // Observer
    private var resultNum = BehaviorSubject(value: 0)
    
    private let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        addingNumberAction()
    }
    
    private func configureHierarchy() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(thirdTextField)
        view.addSubview(plusLabel)
        view.addSubview(divider)
        view.addSubview(resultLabel)
    }
    private func configureLayout() {
        thirdTextField.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        secondTextField.snp.makeConstraints { make in
            make.bottom.equalTo(thirdTextField.snp.top).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(thirdTextField)
            make.horizontalEdges.equalTo(thirdTextField)
        }
        
        firstTextField.snp.makeConstraints { make in
            make.bottom.equalTo(secondTextField.snp.top).offset(-8)
            make.height.equalTo(30)
            make.width.equalTo(thirdTextField)
            make.horizontalEdges.equalTo(thirdTextField)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(thirdTextField.snp.leading).offset(-8)
            make.centerY.equalTo(thirdTextField)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(plusLabel.snp.leading)
            make.trailing.equalTo(thirdTextField.snp.trailing)
            make.top.equalTo(thirdTextField.snp.bottom).offset(8)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(divider)
            make.top.equalTo(divider.snp.bottom).offset(8)
        }
        
    }
    private func configureView() {
        view.backgroundColor = .white
        [firstTextField, secondTextField, thirdTextField].forEach { tf in
            tf.borderStyle = .roundedRect
            tf.font = .systemFont(ofSize: 14)
            tf.textAlignment = .right
            tf.keyboardType = .numberPad
        }
        firstTextField.text = "1"
        secondTextField.text = "2"
        thirdTextField.text = "3"
        
        divider.backgroundColor = .darkGray
        
        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 17)
        plusLabel.textColor = .black
        
        resultLabel.text = "1"
        resultLabel.font = .systemFont(ofSize: 17)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .right
    }
    private func addingNumberAction() {
//        Observable.combineLatest(firstTextField.rx.text.orEmpty, secondTextField.rx.text.orEmpty, thirdTextField.rx.text.orEmpty) {
//            (Int($0) ?? 0) + (Int($1) ?? 0) + (Int($2) ?? 0)
//        }
//        .map { String($0) }
//        .bind(to: resultLabel.rx.text)
//        .disposed(by: disposebag)
        
        firstTextField.rx.text.orEmpty
            .map({ Int($0) ?? -1 })
            .bind(with: self) { owner, num1 in
                owner.num1 = num1
                owner.resultNum.onNext(owner.num1+owner.num2+owner.num3)
            }
            .disposed(by: disposebag)
        
        secondTextField.rx.text.orEmpty
            .map({ Int($0) ?? -1 })
            .bind(with: self) { owner, num2 in
                owner.num2 = num2
                owner.resultNum.onNext(owner.num1+owner.num2+owner.num3)
            }
            .disposed(by: disposebag)

        thirdTextField.rx.text.orEmpty
            .map({ Int($0) ?? -1 })
            .bind(with: self) { owner, num3 in
                owner.num3 = num3
                owner.resultNum.onNext(owner.num1+owner.num2+owner.num3)
            }
            .disposed(by: disposebag)
        
        resultNum
            .map({ String($0) })
            .bind(with: self) { owner, result in
                owner.resultLabel.text = "\(result)"
            }
            .disposed(by: disposebag)
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
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
        
        divider.backgroundColor = .darkGray
        
        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 17)
        plusLabel.textColor = .black
        
        resultLabel.text = "1"
        resultLabel.font = .systemFont(ofSize: 17)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .right
    }
}

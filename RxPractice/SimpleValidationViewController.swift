//
//  SimpleValidationViewController.swift
//  RxPractice
//
//  Created by 김상규 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleValidationViewController: UIViewController {
    
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let nicknameValidationLabel = UILabel()
    
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidationLabel = UILabel()
    
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(nicknameValidationLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        view.addSubview(loginButton)
    }
    func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        nicknameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameValidationLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        nicknameLabel.text = "Nickname"
        passwordLabel.text = "Password"
        nicknameValidationLabel.text = "Nickname has to be at least \(5) characters"
        passwordValidationLabel.text = "Password has to be at least \(5) characters"
        
        nicknameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        nicknameValidationLabel.textColor = .red
        passwordValidationLabel.textColor = .red
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .green
    }
}

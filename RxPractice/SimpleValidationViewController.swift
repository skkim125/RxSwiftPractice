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
    
    private var nicknameValid = false
    private var passwordValid = false
    private var loginIsEnabld = BehaviorSubject(value: false)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        validAction()
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
            make.top.equalTo(nicknameValidationLabel.snp.bottom).offset(15)
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
        nicknameLabel.font = .boldSystemFont(ofSize: 17)
        passwordLabel.text = "Password"
        passwordLabel.font = .boldSystemFont(ofSize: 17)
        nicknameValidationLabel.text = "Nickname has to be at least \(5) characters"
        passwordValidationLabel.text = "Password has to be at least \(5) characters"
        
        nicknameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        nicknameValidationLabel.textColor = .red
        passwordValidationLabel.textColor = .red
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .green
    }
    
    func validAction() {
        
        let nicknameValid = nicknameTextField.rx.text.orEmpty
            .map({ $0.count >= 5 })
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map({ $0.count >= 5 })
        
        nicknameValid
            .bind(to: nicknameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        //        Observable.combineLatest(nicknameValid, passwordValid)
        //            .map({ $0.0 && $0.1 })
        //            .bind(with: self) { owner, isEnabled in
        //                owner.loginButton.isEnabled = isEnabled
        //                owner.loginButton.setTitleColor(isEnabled ? .black : .white , for: .normal)
        //            }
        //            .disposed(by: disposeBag)
        
        nicknameValid
            .bind(with: self) { owner, isValid in
                owner.nicknameValid = isValid
                owner.checkAllValid()
            }
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(with: self) { owner, isValid in
                owner.passwordValid = isValid
                owner.checkAllValid()
            }
            .disposed(by: disposeBag)
        
        loginIsEnabld
            .bind(with: self) { owner, isAllValid in
                owner.loginButton.isEnabled = isAllValid
                owner.loginButton.setTitleColor(isAllValid ? .black : .white , for: .normal)
            }
            .disposed(by: disposeBag)

        
        loginButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "로그인 성공", message: "로그인 되어있습니다.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    func checkAllValid() {
        if nicknameValid && passwordValid == true {
            loginIsEnabld.onNext(true)
        } else {
            loginIsEnabld.onNext(false)
        }
    }
}

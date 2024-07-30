//
//  ViewController.swift
//  RxPractice
//
//  Created by 김상규 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ViewController: UIViewController {
    
    let textField = UITextField()
    let resultLabel = UILabel()
    let button = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        //setRxButtonStepOne()
        //setRxButtonStepTwo()
        //setRxButtonStepThree()
        //setRxButtonStepFour()
        //setRxButtonStepFive()
        //setRxButtonStepSix()
        //setRxButtonStepSeven()
        //setRxButtonStepEight()
        setRxButtonStepNine()
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultLabel)
        view.addSubview(button)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(40)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        textField.backgroundColor = .yellow
        textField.placeholder = "입력하세요"
        textField.textAlignment = .center
        
        resultLabel.backgroundColor = .brown
        resultLabel.textAlignment = .center
        
        button.backgroundColor = .cyan
        button.setTitle("버튼", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    // 1) 기본 형태
    func setRxButtonStepOne() {
        button.rx.tap
            .subscribe { _ in
                self.resultLabel.text = "\(self.textField.text ?? "입력 이슈")"
            } onError: { error in
                print(error)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 2) 매개변수가 사용되지 않다는 것을 확인 => 축약.ver
    func setRxButtonStepTwo() {
        button.rx.tap
            .subscribe { _ in
                self.resultLabel.text = "\(self.textField.text ?? "입력 이슈")"
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 3) 강한 참조 순환를 방지하기 위해 약한 참조 코드 추가.ver
    func setRxButtonStepThree() {
        button.rx.tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.resultLabel.text = "\(self.textField.text ?? "입력 이슈")"
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 4) 3).함축.ver
    func setRxButtonStepFour() {
        button.rx.tap
            .withUnretained(self)
            .subscribe { _ in
                self.resultLabel.text = "\(self.textField.text ?? "입력 이슈")"
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 5) 가장 많이 사용되는 케이스
    func setRxButtonStepFive() {
        button.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.resultLabel.text = owner.textField.text ?? "입력 없음"
            }, onDisposed: { owner in
                print("disposed")
            })
            .disposed(by: disposeBag)
    }
    
    // 6) 쓰레드 이슈 해결.ver
    func setRxButtonStepSix() {
        button.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                DispatchQueue.main.async {
                    owner.resultLabel.text = owner.textField.text ?? "입력 없음"
                }
            }, onDisposed: { owner in
                print("disposed")
            })
            .disposed(by: disposeBag)
    }
    
    // 7) 6).함축.ver
    func setRxButtonStepSeven() {
        button.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, _ in
                owner.resultLabel.text = owner.textField.text ?? "입력 없음"
            }, onDisposed: { owner in
                print("disposed")
            })
            .disposed(by: disposeBag)
    }
    
    // 8) 7)을 함축한 최종 코드
    func setRxButtonStepEight() {
        button.rx.tap
            .bind(with: self, onNext: { owner, _ in
                owner.resultLabel.text = owner.textField.text ?? "입력 없음"
            })
            .disposed(by: disposeBag)
    }
    
    // + bind(to:)로 직접 값을 전달하는 코드
    func setRxButtonStepNine() {
        button.rx.tap
            .map { "버튼 터치됨" }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}


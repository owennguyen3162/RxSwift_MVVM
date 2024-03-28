//
//  ViewController.swift
//  RxSwift_MVVM
//
//  Created by Nguyễn Linh on 18/03/2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setupQueue()
        setUpRxSwift()
    }
    
    func setUpRxSwift () {
        let helloRx = Observable.just("Hello RxSwift").subscribe{
            (value) in
            print("kkkk \(value)")
        }
    }
    
    func setupQueue () {
        let queue = DispatchQueue(label: "myQueue", qos: .utility, attributes: .concurrent)
        
        queue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        queue.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        queue.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
    }
}


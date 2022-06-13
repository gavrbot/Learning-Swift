//
//  ViewController.swift
//  MVVM_example
//
//  Created by Александр Гаврилов on 13.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!

    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.userButtonPressed(login: (loginField.text ?? ""), password: (passField.text ?? ""))
    }
    @IBOutlet weak var label: UILabel!
    
    var viewModel = ViewModel()
    
    func initialState() {
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initialState()
    }
    
    func bindViewModel() {
        viewModel.statusText.bind({ (statusText) in
             // отправляем в главный поток выполнения, так как это интерфейс
            DispatchQueue.main.async {
                self.label.text = statusText
            }
        })
        viewModel.statusColor.bind({ (statusColor) in
            DispatchQueue.main.async {
                self.label.textColor = statusColor
            }
        })
    }

}


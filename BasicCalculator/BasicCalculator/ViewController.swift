//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Sai Kiran Anumalla on 20/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    var basicCalculaterLabel: UILabel!
    var operationsLabel: UILabel!
    var resultLabel: UILabel!
       
    var inputNumber1: UITextField!
    var inputNumber2: UITextField!

    func setupLabel(text: String, fontSize: CGFloat, isBold: Bool = false, topAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        return label
    }

    func setupTextField(placeholder: String, topAnchor: NSLayoutYAxisAnchor) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        return textField
    }

    func setupButton(title: String, selector: Selector, topAnchor: NSLayoutYAxisAnchor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicCalculaterLabel = setupLabel(text: "Basic Calculator", fontSize: 28, isBold: true, topAnchor: view.safeAreaLayoutGuide.topAnchor, constant: 32)
                
        inputNumber1 = setupTextField(placeholder: "First Number", topAnchor: basicCalculaterLabel.bottomAnchor)
        inputNumber2 = setupTextField(placeholder: "Second Number", topAnchor: inputNumber1.bottomAnchor)
        
        operationsLabel = setupLabel(text: "Operations", fontSize: 24, topAnchor: inputNumber2.bottomAnchor, constant: 16)
        
        let addButton = setupButton(title: "Add", selector: #selector(onAddButtonTapped), topAnchor: operationsLabel.bottomAnchor)
        let subButton = setupButton(title: "Subtract", selector: #selector(onSubButtonTapped), topAnchor: addButton.bottomAnchor)
        let multiplyButton = setupButton(title: "Multiply", selector: #selector(onMultiplyButtonTapped), topAnchor: subButton.bottomAnchor)
        let divButton = setupButton(title: "Divide", selector: #selector(onDivButtonTapped), topAnchor: multiplyButton.bottomAnchor)
        
        resultLabel = setupLabel(text: "Result", fontSize: 24, isBold: true, topAnchor: divButton.bottomAnchor, constant: 16)
    }

    @objc func onAddButtonTapped() {
       showResultAfterUserInputs(operation: "Add")
    }
       
    @objc func onSubButtonTapped() {
       showResultAfterUserInputs(operation: "Subtract")
    }
   
    @objc func onMultiplyButtonTapped() {
       showResultAfterUserInputs(operation: "Multiply")
    }
   
    @objc func onDivButtonTapped() {
       showResultAfterUserInputs(operation: "Divide")
    }
   
    func showResultAfterUserInputs(operation: String) {
       guard let unwrappedInputNumber1 = inputNumber1.text, !unwrappedInputNumber1.isEmpty else {
           showErrorAlertWithMessage(errorMessage: "Error! The numbers cannot be empty!")
           return
       }
       
       guard let unwrappedInputNumber2 = inputNumber2.text, !unwrappedInputNumber2.isEmpty else {
           showErrorAlertWithMessage(errorMessage: "Error! The numbers cannot be empty!")
           return
       }
       
       guard let firstNumber = Double(unwrappedInputNumber1) else {
           showErrorAlertWithMessage(errorMessage: "The first operand is not valid")
           return
       }
       
       guard let secondNumber = Double(unwrappedInputNumber2) else {
           showErrorAlertWithMessage(errorMessage: "The second operand is not valid")
           return
       }
       
       switch operation.lowercased() {
           case "add":
               resultLabel.text = formatResult(firstNumber + secondNumber)
           case "subtract":
               resultLabel.text = formatResult(firstNumber - secondNumber)
           case "multiply":
               resultLabel.text = formatResult(firstNumber * secondNumber)
           case "divide":
               guard secondNumber != 0 else {
                   showErrorAlertWithMessage(errorMessage: "The denominator cannot be 0")
                   return
               }
               resultLabel.text = formatResult(firstNumber / secondNumber)
           default:
               print("Invalid operation")
           }
   }
   
   func formatResult(_ result: Double) -> String {
       return String(format: "%.2f", result)
   }
   
   func showErrorAlertWithMessage(errorMessage: String) {
       let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default))
       self.present(alert, animated: true)
   }

}


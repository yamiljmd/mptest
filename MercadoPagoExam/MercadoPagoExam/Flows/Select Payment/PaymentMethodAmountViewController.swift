//
//  PaymentMethodAmountViewController.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 23/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

class PaymentMethodAmountViewController: UIViewController, PaymentScreen {//, UITextFieldDelegate {

    @IBOutlet weak var amountContainer: UIView!
//    @IBOutlet weak var amountField: UITextField!
//    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var continueButton: UIButton!
//    private var formatter: NumberFormatter?
//    private let minimumAmount = NSNumber(value: 0)
    
    var selectedPaymentInfo: SelectedPaymentInfo?
    var currentStep: PaymentStep?
    var dataSource: PaymentMethodComponentDataSource?
    weak var flowManager: SelectPaymentFlowManager?
    var amountField: NumericTextFieldViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        amountField.delegate = self
//        amountField.inputAccessoryView = continueButton.inputView
        
//        formatter = createFormatter()
        
//        errorLabel.isHidden = true
//        errorLabel.text = "El monto debe ser mayo a cero" //TODO: Internacionalizar
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedPayment = selectedPaymentInfo else {
            return
        }
        
        if selectedPayment.hasAnAmount() {
            //TODO: revisar
            amountField?.resignFirstResponder()
        } else {
            amountField?.value = 0
//            amountField.text = formatter?.string(from: 0)
            amountField?.becomeFirstResponder()
        }
        
        if selectedPayment.isComplete {
            amountField?.value = 0//formatter?.string(from: 0)
            flowManager?.presentPaymentInfoMessage(selectedPayment)
        }
    }
    
    
    // MARK: - Navigation
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
//        guard isValidAmount(), let amount = amountField.text else {
//            errorLabel.isHidden = false
//            return
//        }
        guard let amountField = amountField, amountField.isValid() else {
            return
        }

        selectedPaymentInfo?.amount = amountField.value//formatter?.number(from: amount)
        
        flowManager?.userDidCompleteInfo(forStep: currentStep, withPaymentInfo: selectedPaymentInfo)
    }
    
//    private func isValidAmount() -> Bool {
//        
//        guard let amount = formatter?.number(from: amountField.text ?? "0") else {
//            return false
//        }
//        return amount.compare(minimumAmount) == .orderedDescending
//    }
    
    //MARK: - UITextFieldDelegate
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        errorLabel.isHidden = true
//        //Evito borrar signo de la moneda
//        if string.isEmpty && textField.text == formatter?.currencySymbol {
//            textField.text = formatter?.currencySymbol ?? "" + " "
//            return false
//        }
//        
//        //valido entradas
//        guard let currentText = textField.text, string.isNumeric() || string.isDecimalSeparator() || string.isEmpty else {
//            return false
//        }
//        
//        //Se admite solo una separador decimal y/o backspace
//        if (string.isDecimalSeparator() && !currentText.containsDecimalSeparator()) || string.isEmpty {
//            return true
//        }
//        
//        let textWithoutGroupingSeparator = currentText.replacingOccurrences(of: (formatter?.groupingSeparator)!, with: "")
//        
//        let newNumber = textWithoutGroupingSeparator + string
//        
//        guard let validNumberFromCurrentText = formatter?.number(from: newNumber) else {
//            return false
//        }
//        
//        if textWithoutGroupingSeparator.containsDecimalSeparator() && string == "0" {
//            textField.text = currentText + string
//        } else {
//            textField.text = formatter?.string(from: validNumberFromCurrentText)
//        }
//        
//        return  false
//    }
    
//    private func createFormatter() -> NumberFormatter {
//        let formatter = NumberFormatter()
//        formatter.locale = AppConfiguration.shared.locale()
//        formatter.minimum = 0
//        formatter.numberStyle = .currency
//        formatter.maximumFractionDigits = 9
//        formatter.minimumFractionDigits = 0
//        return formatter
//    }

    
    @IBAction func resignFirstResponder(_ sender: UITapGestureRecognizer) {
        amountField?.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "amountIdentifier" {
            if let destination = segue.destination as? NumericTextFieldViewController {
                amountField = destination
            }
        }
    }
    
    
//    func keyboardNotification(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
//            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
//            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
//            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
//            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
//                self.keyboardHeightLayoutConstraint?.constant = 0.0
//            } else {
//                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//            }
//            UIView.animate(withDuration: duration,
//                           delay: TimeInterval(0),
//                           options: animationCurve,
//                           animations: { self.view.layoutIfNeeded() },
//                           completion: nil)
//        }
//    }
    
}


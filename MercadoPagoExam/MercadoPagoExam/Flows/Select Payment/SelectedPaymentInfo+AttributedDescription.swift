//
//  SelectedPaymentInfo+AttributedDescription.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 3/7/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import UIKit

extension SelectedPaymentInfo {
    
    
    //TODO: esto habría que internacionalizarlo
    private struct Texts {
        static let amount = "Importe"
        static let paymentMethod = "Medio de pago"
        static let issuer = "Emisor"
        static let installments = "Cuotas"
        static let separator = ": "
    }
    
    var fontSize: CGFloat {
        get {
            return UIFont.systemFontSize
        }
    }
    
    var bold: [String : Any] {
        get {
            return [NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize),
                    NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
    }
    
    var noBold: [String : Any] {
        get {
            return [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
                    NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
    }
    
    var separator: String {
        get {
            return Texts.separator
        }
    }
    
    var paragraphStyle: NSParagraphStyle {
        get {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            return paragraphStyle
        }
    }
    
    
    var newLine: NSAttributedString {
        get {
            return NSAttributedString(string: "\n", attributes: nil)
        }
    }
    
    func attributedDescription() -> NSAttributedString? {
        
        guard let amount = self.amount, let methodName = self.method?.name, let payerCost = self.installmentsPayerCost else {
            return nil
        }
        
        let newMessage = NSMutableAttributedString()
        
        newMessage.append(newLine)
        
        newMessage.append(createMessagePart(title: Texts.amount, text: amount.fractionDigits()))
        
        newMessage.append(newLine)
        
        newMessage.append(createMessagePart(title: Texts.paymentMethod, text: methodName))
        
        newMessage.append(newLine)
        
        if let issuerName = self.cardIssuer?.name {
            newMessage.append(createMessagePart(title: Texts.issuer, text: issuerName))
            newMessage.append(newLine)
        }
        
        newMessage.append(createMessagePart(title: Texts.installments, text: payerCost.recommendedMessage))
        
        return newMessage
        
    }
    
    private func createMessagePart(title: String, text: String) -> NSMutableAttributedString {
        
        let messagePart = NSMutableAttributedString(string: title, attributes: bold)
        
        messagePart.append(NSAttributedString(string: separator, attributes: bold))
        
        let textPart = NSAttributedString(string: text, attributes: noBold)
        
        messagePart.append(textPart)
        
        return messagePart
    }
}

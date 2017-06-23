//
//  PaymentMethodsService.swift
//  MercadoPagoExam
//
//  Created by Yamil Jalil Maluf on 18/6/17.
//  Copyright © 2017 Yamil Jalil Maluf. All rights reserved.
//

import Foundation

final class PaymentMethodsService {
    
    let apiConnector = PaymentMethodsAPIConnector()
    
    var delegate: PaymentMethodsServiceDelegate
    
    init(delegate: PaymentMethodsServiceDelegate) {
        self.delegate = delegate
    }

    func retrivePaymentMethods() {
        
        let onError = { (error: Error) -> Void in
            self.delegate.informError(error)
        }

        let onSucces = { (models: [PaymentMethod]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            self.delegate.updatePaymentMethods(models)
        }

        let paymentMethodModelCreator = ModelCreator<PaymentMethod>(onSucces: onSucces, onError: onError)
        
        apiConnector.retrievePaymentMethods(withModelCreator: paymentMethodModelCreator)
    }

    
    func retriveCardIssuers(paymentMethodId: String) {
        
        let onError = { (error: Error) -> Void in
            self.delegate.informError(error)
        }
        
        let onSucces = { (models: [CardIssuer]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            self.delegate.updateCardIssuers(models)
        }
        
        let cardIssuerModelCreator = ModelCreator<CardIssuer>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveCardIssuers(forPaymentMethodId: paymentMethodId, withModelCreator: cardIssuerModelCreator)
    }
    
    func retriveInstallments(paymentMethodId: String, issuerId: String, amount: Double) {
        
        let onError = { (error: Error) -> Void in
            self.delegate.informError(error)
        }
        
        let onSucces = { (models: [Installments]?) -> Void in
            //Acá se podría realizar validaciones sobre los modelos antes de pasarlos al delegate
            self.delegate.updateInstallments(models)
        }
        
        let installmentsModelCreator = ModelCreator<Installments>(onSucces: onSucces, onError: onError)
        
        apiConnector.retriveInstallments(forPaymentMethodId: paymentMethodId, andIssuerId: issuerId, andAmount: amount, withModelCreator: installmentsModelCreator)
        
    }
    
}

//
//  PaymentViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation
import Stripe
import StripePayments
import StripeApplePay
import PassKit
import UIKit

class PaymentViewModel: NSObject, ObservableObject {
    @Published var isSuccess: Bool = false
    @Published var paymentSuccess : Bool = false

    let usecase: PaymentUsecaseProtocol

    init(usecase: PaymentUsecaseProtocol) {
        self.usecase = usecase
    }

    func startApplePay(amount: Double, currency:String) {
        let paymentRequest = StripeAPI.paymentRequest(
            withMerchantIdentifier: "merchant.com.iti.shoprenia",
            country: "US",
            currency: currency
        )

        paymentRequest.requiredBillingContactFields = []
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Shoprenia", amount: NSDecimalNumber(value: amount))
        ]

        guard StripeAPI.canSubmitPaymentRequest(paymentRequest) else {
            print("Apple Pay is not available or not configured properly.")
            return
        }

        let paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController.delegate = self
        paymentController.present(completion: nil)
    }

    func confirmOrder(shipping: Int, code: String?, discount: Double?) {
        usecase.placeOrder(shipping: shipping, code: code, discount: discount) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.isSuccess = true
                case .failure(_):
                    self?.isSuccess = false
                }
            }
        }
    }

    func createPaymentIntent(amount: Double, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://stripe-mobile-payment-sheet.glitch.me/checkout") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json: [String: Any] = [
            "amount": Int(amount * 100),
            "currency": "usd"
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: json)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }

            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let clientSecret = json["paymentIntent"] as? String else {
                print("Failed to get client secret: \(error?.localizedDescription ?? "unknown error")")
                completion(nil)
                return
            }

            print("Received client secret: \(clientSecret)")
            completion(clientSecret)
        }.resume()
    }
}

extension PaymentViewModel: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController,
                                        didAuthorizePayment payment: PKPayment,
                                        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        STPAPIClient.shared.createPaymentMethod(with: payment) { paymentMethod, error in
            if let error = error {
                print("Error creating payment method: \(error.localizedDescription)")
                completion(PKPaymentAuthorizationResult(status: .failure, errors: [error]))
                return
            }

            print("Apple Pay authorized, finalizing order")
            self.paymentSuccess = true
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss(completion: nil)
    }
}

//
//  IAPManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/17.
//

import StoreKit

typealias ProductsRequestCompletion = (_ success: Bool, _ products: [SKProduct]?) -> Void

protocol IAPManagerType {
  var canMakePayments: Bool { get }
  
  func getProducts(completion: @escaping ProductsRequestCompletion)
  func buyProduct(_ product: SKProduct)
  func isProductPurchased(_ productID: String) -> Bool
  func restorePurchases()
}

final class IAPManager: NSObject, IAPManagerType {
    
    // MARK: - Properties
    
    private let productIDs: Set<String>
    private var purchasedProductIDs: Set<String> = []
    private var productsRequest: SKProductsRequest?
    private var productsCompletion: ProductsRequestCompletion?
    
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }
    
    
    // MARK: - Init
    
    init(productIDs: Set<String>) {
        self.productIDs = productIDs
        
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func getProducts(completion: @escaping ProductsRequestCompletion) {
        self.productsRequest?.cancel()
        self.productsCompletion = completion
        self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs)
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
    }
    
    func buyProduct(_ product: SKProduct) {
        SKPaymentQueue.default().add(SKPayment(product: product))
    }
    
    func isProductPurchased(_ productID: String) -> Bool {
        self.purchasedProductIDs.contains(productID)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


// MARK: - Extension: SKProductsRequestDelegate

extension IAPManager: SKProductsRequestDelegate {
  // didReceive
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    self.productsCompletion?(true, products)
    self.clearRequestAndHandler()
    
    products.forEach { print("Found product: \($0.productIdentifier) \($0.localizedTitle) \($0.price.floatValue)") }
  }
  
  // failed
  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Erorr: \(error.localizedDescription)")
    self.productsCompletion?(false, nil)
    self.clearRequestAndHandler()
  }
  
  private func clearRequestAndHandler() {
    self.productsRequest = nil
    self.productsCompletion = nil
  }
}

// MARK: - Extension: SKPaymentTransactionObserver

extension IAPManager: SKPaymentTransactionObserver {
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    transactions.forEach {
      switch $0.transactionState {
      case .purchased:
        print("completed transaction")
        self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction($0)
      case .failed:
        if let transactionError = $0.error as NSError?,
           let description = $0.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
          print("Transaction erorr: \(description)")
        }
        SKPaymentQueue.default().finishTransaction($0)
      case .restored:
        print("failed transaction")
        self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction($0)
      case .deferred:
        print("deferred")
      case .purchasing:
        print("purchasing")
      default:
        print("unknown")
      }
    }
  }
  
  private func deliverPurchaseNotificationFor(id: String?) {
    guard let id = id else { return }
    
    self.purchasedProductIDs.insert(id)
    UserDefaults.standard.set(true, forKey: id)
    NotificationCenter.default.post(
      name: .iapServicePurchaseNotification,
      object: id
    )
  }
}

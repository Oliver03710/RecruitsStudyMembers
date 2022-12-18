//
//  SKManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/18.
//

import StoreKit

final class SKManager: NSObject {
    
    // MARK: - Properties
    
    static let shared = SKManager()
    private var productsRequest: SKProductsRequest?
    
    var productIds: Set<String> = BackgroundIAPBundles.bundles.union(FaceIAPBundles.bundles)
    var products: [SKProduct]?
    
    var prices: [String] = []
    var productsIdentifier: [String] = []
    
    var productsType: ShopViewSelected = .background
    
    
    // MARK: - Init
    
    private override init() { }
    
    
    // MARK: - Helper Functions
    
    func getProducts() {
        self.productsRequest?.cancel()
        self.productsRequest = SKProductsRequest(productIdentifiers: productIds)
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
    }
    
    func purchase(productParam : SKProduct) {
        guard let products = products, products.count > 0 else { return }
        let payment = SKPayment(product: productParam)
        SKPaymentQueue.default().add(payment)
    }
    
    func isProductPurchased(_ productID: String) -> Bool {
        self.productIds.contains(productID)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}


// MARK: - Extension: SKProductsRequestDelegate

extension SKManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("recevied products")
        products = response.products
        prices.removeAll(keepingCapacity: true)
        productsIdentifier.removeAll(keepingCapacity: true)
        
        guard let products = products else { return }
        products.forEach {
            print("Found product: \($0.productIdentifier) \($0.localizedTitle) \($0.price)")
            prices.append("\($0.price)")
            productsIdentifier.append("\($0.productIdentifier)")
        }
        print(prices)
        print(productsIdentifier)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("error")
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("the request is finished")
    }
}


// MARK: - Extension: SKPaymentTransactionObserver

extension SKManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        let vc = BlockingViewController()
        
        transactions.forEach {
            
            if let error = $0.error {
                print("error: \(error.localizedDescription)")
            }
            
            switch $0.transactionState {
            case .purchasing:
                print("handle purchasing state")
                
                vc.modalPresentationStyle = .overFullScreen
                UIApplication.getTopMostViewController()?.present(vc, animated: true)
                
            case .purchased:
                guard let receiptFileURL = Bundle.main.appStoreReceiptURL else { return }
                let receiptData = try? Data(contentsOf: receiptFileURL)
                guard let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) else { return }
                NetworkManager.shared.receipt.accept(receiptString)
                
                SKPaymentQueue.default().finishTransaction($0)
                
            case .restored:
                print("handle restored state")
                
            case .failed:
                print("구매취소")
                NetworkManager.shared.isDismissed.accept(true)
                
                SKPaymentQueue.default().finishTransaction($0)
                
            case .deferred:
                print("handle deferred state")
                
            @unknown default:
                print("Fatal Error")
            }
        }
    }
}

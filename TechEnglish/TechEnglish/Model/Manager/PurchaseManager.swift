//
//  PurchaseManager.swift
//  TechEnglish
//
//  広告オフ買い切り（Non-Consumable / entitlement "ad_free"）の状態を
//  RevenueCat 経由で一元管理するマネージャ。
//

import Foundation
import RevenueCat
import FirebaseAnalytics

final class PurchaseManager: NSObject {

    static let shared = PurchaseManager()

    /// entitlement 識別子（ASC / RevenueCat 側の設定と一致させる）
    static let adFreeEntitlementID = "ad_free"

    /// 広告オフの保有状態が変わったときに通知される
    static let adFreeStatusChangedNotification = Notification.Name("adFreeStatusChanged")

    /// アプリ埋め込み用の公開 SDK キー（秘密鍵ではない）
    private static let apiKey = "appl_KUGGBDMscDsnWwCMJszAJXqqhrN"

    private static let isAdFreeDefaultsKey = "isAdFree"

    /// 広告オフを保有しているか。UI から同期アクセスするためにキャッシュする。
    private(set) var isAdFree: Bool {
        get { UserDefaults.standard.bool(forKey: Self.isAdFreeDefaultsKey) }
        set {
            let old = UserDefaults.standard.bool(forKey: Self.isAdFreeDefaultsKey)
            UserDefaults.standard.set(newValue, forKey: Self.isAdFreeDefaultsKey)
            if old != newValue {
                NotificationCenter.default.post(name: Self.adFreeStatusChangedNotification, object: nil)
            }
        }
    }

    private override init() { super.init() }

    // MARK: - Setup

    /// アプリ起動時に一度だけ呼ぶ
    func configure() {
        Purchases.logLevel = .info
        Purchases.configure(withAPIKey: Self.apiKey)
        Purchases.shared.delegate = self
        refresh()
    }

    /// 最新の CustomerInfo を取得して isAdFree を更新
    func refresh() {
        Purchases.shared.getCustomerInfo { [weak self] customerInfo, _ in
            guard let self = self, let customerInfo = customerInfo else { return }
            self.updateAdFree(from: customerInfo)
        }
    }

    // MARK: - Purchase

    /// 広告オフ商品を購入する
    /// - Parameter completion: (成功, ユーザーキャンセル, エラー)。メインスレッドで呼ばれる。
    func purchaseAdFree(completion: @escaping (_ success: Bool, _ userCancelled: Bool, _ error: Error?) -> Void) {
        Purchases.shared.getOfferings { [weak self] offerings, error in
            if let error = error {
                completion(false, false, error)
                return
            }
            guard let package = offerings?.current?.availablePackages.first else {
                completion(false, false, nil)
                return
            }
            Purchases.shared.purchase(package: package) { _, customerInfo, error, userCancelled in
                guard let self = self else { return }
                if userCancelled {
                    completion(false, true, nil)
                    return
                }
                if let error = error {
                    completion(false, false, error)
                    return
                }
                if let customerInfo = customerInfo {
                    self.updateAdFree(from: customerInfo)
                }
                if self.isAdFree {
                    self.logPurchase(package: package)
                }
                completion(self.isAdFree, false, nil)
            }
        }
    }

    /// 購入を復元する
    /// - Parameter completion: (広告オフを保有しているか, エラー)。メインスレッドで呼ばれる。
    func restore(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        Purchases.shared.restorePurchases { [weak self] customerInfo, error in
            guard let self = self else { return }
            if let error = error {
                completion(false, error)
                return
            }
            if let customerInfo = customerInfo {
                self.updateAdFree(from: customerInfo)
            }
            completion(self.isAdFree, nil)
        }
    }

    /// 広告オフ商品の表示用価格（例: "¥300"）。取得できなければ nil。
    func fetchAdFreePriceString(completion: @escaping (String?) -> Void) {
        Purchases.shared.getOfferings { offerings, _ in
            let price = offerings?.current?.availablePackages.first?.storeProduct.localizedPriceString
            DispatchQueue.main.async { completion(price) }
        }
    }

    // MARK: - Private

    private func updateAdFree(from customerInfo: CustomerInfo) {
        let active = customerInfo.entitlements[Self.adFreeEntitlementID]?.isActive == true
        DispatchQueue.main.async {
            self.isAdFree = active
        }
    }

    /// 購入成功を Firebase に記録（ファネル計測用。RevenueCat 側は自動計測）。
    private func logPurchase(package: Package) {
        let product = package.storeProduct
        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterValue: NSDecimalNumber(decimal: product.price).doubleValue,
            AnalyticsParameterCurrency: product.currencyCode ?? "",
            AnalyticsParameterItemID: product.productIdentifier
        ])
    }
}

// MARK: - PurchasesDelegate

extension PurchaseManager: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        updateAdFree(from: customerInfo)
    }
}

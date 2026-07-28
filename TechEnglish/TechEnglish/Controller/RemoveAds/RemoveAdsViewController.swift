//
//  RemoveAdsViewController.swift
//  TechEnglish
//
//  広告オフ（買い切り）の paywall 画面。
//

import UIKit
import FirebaseAnalytics

/// paywall をどの導線から開いたか（Firebase の `source` パラメータに載せる）。
/// どの導線が購入に効いたかを比較するために使う。
enum PaywallSource: String {
    /// Learn タブ（クイズがある1ページ目）の常設バーボタン
    case learnNav = "learn_nav"
    /// My Cards タブの常設バーボタン
    case myCardsNav = "mycards_nav"
    /// クイズ完了時に出るボタン
    case quizEnd = "quiz_end"
}

final class RemoveAdsViewController: UIViewController {

    // MARK: - Properties

    /// この paywall を開いた導線。計測にのみ使う。
    private let source: PaywallSource

    // MARK: - Initializer

    init(source: PaywallSource) {
        self.source = source
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let benefit1Label = UILabel()
    private let benefit2Label = UILabel()
    private let purchaseButton = EditorButton()
    private let restoreButton = EditorButton()
    private let indicator = UIActivityIndicatorView(style: .large)

    /// 取得済みの表示価格（"¥300" など）。ボタンタイトルに反映する。
    private var priceString: String?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        EditorTheme.applyToModalViewController(self)
        setupViews()
        updatePurchaseButtonTitle()
        loadPrice()
        // 既に広告オフなら購入導線を伏せる
        if PurchaseManager.shared.isAdFree {
            purchaseButton.isEnabled = false
            purchaseButton.setTitle(NSLocalizedString("remove_ads_success_title", comment: ""), for: .normal)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent("paywall_view", parameters: ["source": source.rawValue])
    }

    // MARK: - Layout

    private func setupViews() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = EditorTheme.textInactive
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        titleLabel.text = NSLocalizedString("remove_ads_title", comment: "")
        titleLabel.font = EditorFonts.monoBold(size: EditorFonts.Size.title)
        titleLabel.textColor = EditorTheme.textDefault

        subtitleLabel.text = NSLocalizedString("remove_ads_subtitle", comment: "")
        subtitleLabel.font = EditorFonts.uiRegular(size: EditorFonts.Size.body)
        subtitleLabel.textColor = EditorTheme.textInactive
        subtitleLabel.numberOfLines = 0

        benefit1Label.text = NSLocalizedString("remove_ads_benefit_1", comment: "")
        benefit2Label.text = NSLocalizedString("remove_ads_benefit_2", comment: "")
        [benefit1Label, benefit2Label].forEach {
            $0.font = EditorFonts.mono(size: EditorFonts.Size.small)
            $0.textColor = EditorTheme.comment
            $0.numberOfLines = 0
        }

        purchaseButton.style = .primary
        purchaseButton.addTarget(self, action: #selector(purchaseTapped), for: .touchUpInside)

        restoreButton.style = .ghost
        restoreButton.setTitle(NSLocalizedString("remove_ads_restore_button", comment: ""), for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)

        indicator.color = EditorTheme.textDefault
        indicator.hidesWhenStopped = true

        let benefits = UIStackView(arrangedSubviews: [benefit1Label, benefit2Label])
        benefits.axis = .vertical
        benefits.spacing = 8

        let stack = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel, benefits, purchaseButton, restoreButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.setCustomSpacing(28, after: benefits)
        stack.translatesAutoresizingMaskIntoConstraints = false

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.addSubview(closeButton)
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            purchaseButton.heightAnchor.constraint(equalToConstant: 52),

            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Price

    private func loadPrice() {
        PurchaseManager.shared.fetchAdFreePriceString { [weak self] price in
            guard let self = self else { return }
            self.priceString = price
            self.updatePurchaseButtonTitle()
        }
    }

    private func updatePurchaseButtonTitle() {
        guard !PurchaseManager.shared.isAdFree else { return }
        let base = NSLocalizedString("remove_ads_purchase_button", comment: "")
        if let price = priceString {
            purchaseButton.setTitle("\(base)  \(price)", for: .normal)
        } else {
            purchaseButton.setTitle(base, for: .normal)
        }
    }

    // MARK: - Actions

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func purchaseTapped() {
        setLoading(true)
        PurchaseManager.shared.purchaseAdFree(source: source) { [weak self] success, userCancelled, error in
            guard let self = self else { return }
            self.setLoading(false)
            if userCancelled { return }
            if let error = error {
                self.showAlert(title: NSLocalizedString("remove_ads_error_title", comment: ""),
                               message: error.localizedDescription)
                return
            }
            if success {
                self.showSuccessAndDismiss()
            }
        }
    }

    @objc private func restoreTapped() {
        setLoading(true)
        PurchaseManager.shared.restore { [weak self] success, error in
            guard let self = self else { return }
            self.setLoading(false)
            if let error = error {
                self.showAlert(title: NSLocalizedString("remove_ads_error_title", comment: ""),
                               message: error.localizedDescription)
                return
            }
            if success {
                self.showSuccessAndDismiss()
            } else {
                self.showAlert(title: NSLocalizedString("remove_ads_restore_none_title", comment: ""),
                               message: NSLocalizedString("remove_ads_restore_none_message", comment: ""))
            }
        }
    }

    // MARK: - Helpers

    private func setLoading(_ loading: Bool) {
        if loading { indicator.startAnimating() } else { indicator.stopAnimating() }
        purchaseButton.isEnabled = !loading
        restoreButton.isEnabled = !loading
        view.isUserInteractionEnabled = !loading
    }

    private func showSuccessAndDismiss() {
        let alert = UIAlertController(
            title: NSLocalizedString("remove_ads_success_title", comment: ""),
            message: NSLocalizedString("remove_ads_success_message", comment: ""),
            preferredStyle: .alert
        )
        EditorTheme.styleAlert(alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        EditorTheme.styleAlert(alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

import UIKit

class DescriptionViewController: UIViewController {

    private let descriptionView = DescriptionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.backgroundColorCheckMode
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.parentViewController = self
        view.addSubview(descriptionView)

        // AutoLayout で中央固定＆サイズ指定
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionView.widthAnchor.constraint(equalToConstant:view.frame.width),
            descriptionView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.8)
        ])

        // DescriptionView のクローズボタンアクションを上書きしたい場合は以下のように通知を飛ばす
        descriptionView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }

    @objc private func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

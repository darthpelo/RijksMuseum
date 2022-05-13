//
//  CollectionPlaceholderView.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

/// Collection placeholder
final class PlaceholderView: UIView {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private let appearance = Appearance()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Assigns a displaying image
    /// - Parameter image: Image model
    func setImage(_ image: UIImage) {
        imageView.image = image
    }

    /// Assigns a title label text
    /// - Parameter title: Text
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    private func setupSubviews() {
        addSubview(stackView)
        stackView.axis = appearance.stackViewAxis
        stackView.alignment = appearance.stackViewAlignment
        stackView.spacing = appearance.stackViewSpacing

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)

        titleLabel.numberOfLines = appearance.titleLabelNumberOfLines
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
        }
    }
}

// MARK: - Appearance

private extension PlaceholderView {
    struct Appearance {
        let stackViewAxis: NSLayoutConstraint.Axis = .vertical
        let stackViewAlignment: UIStackView.Alignment = .center
        let stackViewSpacing: CGFloat = 5.0
        let titleLabelNumberOfLines: Int = 0
    }
}

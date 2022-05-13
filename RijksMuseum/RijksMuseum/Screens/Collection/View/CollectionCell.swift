//
//  CollectionCell.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

/// Displays photo cell on search results screen
final class CollectionCell: UICollectionViewCell, CollectionPresentable {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let placeholderLabel = UILabel()

    private let appearance = Appearance()

    private var onPrepareForReuse: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPlaceholder() {
        placeholderLabel.text = appearance.placeholderLabel
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        placeholderLabel.text = nil
    }

    func setOnPrepareForReuse(_ onPrepareForReuse: @escaping () -> Void) {
        self.onPrepareForReuse = onPrepareForReuse
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        placeholderLabel.frame = bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
        placeholderLabel.text = nil

        onPrepareForReuse?()
    }

    private func setupSubviews() {
        backgroundColor = appearance.backgroundColor

        addSubview(placeholderLabel)
        placeholderLabel.numberOfLines = appearance.titleLabelNumberOfLines
        placeholderLabel.textAlignment = appearance.placeholderLabelTextAlignment

        addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.numberOfLines = appearance.titleLabelNumberOfLines
        titleLabel.textAlignment = appearance.titleLabelTextAligment

        imageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.right.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
    }
}

// MARK: - Appearance

private extension CollectionCell {
    struct Appearance {
        let backgroundColor: UIColor = .systemGray
        let titleLabelNumberOfLines: Int = 0
        let placeholderLabelTextAlignment: NSTextAlignment = .center
        let titleLabelTextAligment: NSTextAlignment = .center
        let placeholderLabel = "Loading..."
    }
}

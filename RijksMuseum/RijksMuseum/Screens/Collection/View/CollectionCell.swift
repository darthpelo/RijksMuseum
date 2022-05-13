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

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-80)
        }
        placeholderLabel.frame = bounds
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
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

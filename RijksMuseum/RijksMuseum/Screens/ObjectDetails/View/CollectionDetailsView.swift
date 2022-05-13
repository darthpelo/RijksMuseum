//
//  CollectionDetailsView.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 12/05/22.
//

import SnapKit
import UIKit

final class CollectionDetailsView: UIView, CollectionPresentable {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let appearance = Appearance()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setPlaceholder() {}

    func setOnPrepareForReuse(_: @escaping () -> Void) {}

    private func setupSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.numberOfLines = appearance.numberOfLines
        titleLabel.textAlignment = appearance.textAlignment

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }

        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
}

extension CollectionDetailsView {
    struct Appearance {
        let numberOfLines = 0
        let textAlignment: NSTextAlignment = .center
    }
}

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

    func setPlaceholder(_: String) {}

    func setOnPrepareForReuse(_: @escaping () -> Void) {}

    private func setupSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)

        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

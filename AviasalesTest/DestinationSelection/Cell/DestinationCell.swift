//
//  DestinationCell.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class DestinationCell: UITableViewCell {

    static let reuseIdentifier = "destination_cell"

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cityCode: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .aviasalesBlue
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(with cityModel: CityViewModel) {
        stackView.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
            stackView.removeArrangedSubview(view)
        }

        titleLabel.text = cityModel.name
        cityCode.text = cityModel.iata

        stackView.addArrangedSubview(titleLabel)

        if let subtitle = cityModel.airportName {
            subtitleLabel.text = subtitle
            stackView.addArrangedSubview(subtitleLabel)
        }

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(stackView)
        contentView.addSubview(cityCode)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: cityCode.leftAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            cityCode.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityCode.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
    }
}

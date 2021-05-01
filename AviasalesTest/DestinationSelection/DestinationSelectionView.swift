//
//  DestinationSelectionView.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

class DestinationSelectionView: UIView {

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DestinationCell.self, forCellReuseIdentifier: DestinationCell.reuseIdentifier)
        return tableView
    }()

    private(set) lazy var destinationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter destination"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white

        addSubview(destinationTextField)
        addSubview(tableView)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            destinationTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            destinationTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            destinationTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),

            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

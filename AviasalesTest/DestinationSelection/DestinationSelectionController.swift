//
//  DestinationSelectionController.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class DestinationSelectionController: UIViewController {

    // MARK: - Public Properties

    var output: DestinationSelectionViewOutput!

    // MARK: - Private Properties

    private(set) lazy var customView = view as! DestinationSelectionView
    private var dataSource = [CityViewModel]()
    private var debouncer = Debouncer(delay: 1)

    // MARK: - Lifecycle

    override func loadView() {
        view = DestinationSelectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Enter destination"
        configure()
    }

    // MARK: - Private methods

    private func configure() {
        customView.destinationTextField.addTarget(self, action: #selector(destinationTextChanged), for: .editingChanged)
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }

    @objc private func destinationTextChanged() {
        let text = customView.destinationTextField.text
        customView.activityIndicator.startAnimating()
        debouncer.call { [weak self] in
            self?.output.didChangeText(to: text)
        }
    }

}

// MARK: - DestinationSelectionViewInput

extension DestinationSelectionController: DestinationSelectionViewInput {

    func showMessage(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func updateDataSource(dataSource: [CityViewModel]) {
        self.dataSource = dataSource
        customView.activityIndicator.stopAnimating()
        customView.tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DestinationSelectionController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DestinationCell.reuseIdentifier, for: indexPath) as? DestinationCell else {
            return UITableViewCell()
        }

        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        output.didSelectCity(cityModel: model)
    }

}

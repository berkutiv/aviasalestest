//
//  DestinationSelectionController.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import UIKit

final class DestinationSelectionController: UIViewController {
    private(set) lazy var customView = view as! DestinationSelectionView

    var output: DestinationSelectionViewOutput!
    private var dataSource = [CityViewModel]()
    private var debouncer = Debouncer(delay: 1)

    override func loadView() {
        view = DestinationSelectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Enter destination"
        configure()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

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

    @objc private func handleScreenTap() {
        view.endEditing(true)
    }
}

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

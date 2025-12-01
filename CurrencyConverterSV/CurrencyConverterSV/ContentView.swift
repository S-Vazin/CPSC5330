//
//  MainViewController.swift
//  CurrencyConverterSV
//
//  Created by Shawn Vazin on 11/30/25.
//

import UIKit

// MARK: - Model (MVC)

struct CurrencyConverter {
    // Exact static rates: 1 USD = rate * currency
    private let rates: [String: Double] = [
        "EUR": 0.86,
        "GBP": 0.76,
        "JPY": 155.51,
        "CAD": 1.40
    ]
    
    func convert(usdAmount: Int, to currencyCode: String) -> Double? {
        guard let rate = rates[currencyCode] else { return nil }
        
        // Raw conversion
        let raw = Double(usdAmount) * rate
        
        // Floor to 2 decimal places (ALWAYS round down)
        let floored = floor(raw * 100) / 100
        
        return floored
    }
}


// MARK: - Main (Input) View Controller

class MainViewController: UIViewController {
    
    // Text field for USD input
    private let usdTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter amount in USD"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Error label for invalid input / no currencies selected
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Labels + switches for each currency
    private let currencySwitches: [(label: UILabel, toggle: UISwitch)] = [
        (UILabel(), UISwitch()),
        (UILabel(), UISwitch()),
        (UILabel(), UISwitch()),
        (UILabel(), UISwitch())
    ]
    
    // Button to trigger conversion
    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Convert", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Supported currencies
    private let currencies = ["EUR", "GBP", "JPY", "CAD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currency Converter"
        view.backgroundColor = .systemBackground
        
        setupUI()
        convertButton.addTarget(self, action: #selector(convertTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.addSubview(usdTextField)
        view.addSubview(errorLabel)
        
        // Configure labels for each currency and add switches
        for (idx, (label, toggle)) in currencySwitches.enumerated() {
            label.text = currencies[idx]
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            toggle.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(label)
            view.addSubview(toggle)
        }
        
        view.addSubview(convertButton)
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            usdTextField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            usdTextField.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            usdTextField.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.7),
            
            errorLabel.topAnchor.constraint(equalTo: usdTextField.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
        ])
        
        var lastBottom: NSLayoutYAxisAnchor = errorLabel.bottomAnchor
        for (idx, (label, toggle)) in currencySwitches.enumerated() {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottom, constant: idx == 0 ? 40 : 20),
                label.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40),
                
                toggle.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                toggle.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40)
            ])
            lastBottom = label.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            convertButton.topAnchor.constraint(equalTo: lastBottom, constant: 40),
            convertButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func convertTapped() {
        errorLabel.isHidden = true
        
        // 1. Validate USD input (integer only)
        guard let usdText = usdTextField.text,
              let usdAmount = Int(usdText),
              usdAmount > 0 else {
            errorLabel.text = "Please enter a valid USD amount (integer only)."
            errorLabel.isHidden = false
            return
        }
        
        // 2. Determine which currencies are selected
        let selectedCurrencies = currencySwitches
            .enumerated()
            .filter { $0.element.toggle.isOn }
            .map { currencies[$0.offset] }
        
        guard !selectedCurrencies.isEmpty else {
            errorLabel.text = "Please select at least one currency."
            errorLabel.isHidden = false
            return
        }
        
        // 3. Navigate to results view controller and pass data
        let resultsVC = ResultsViewController()
        resultsVC.usdAmount = usdAmount
        resultsVC.selectedCurrencies = selectedCurrencies
        navigationController?.pushViewController(resultsVC, animated: true)
    }
}

// MARK: - Results (Output) View Controller

class ResultsViewController: UIViewController {
    
    var usdAmount: Int = 0
    var selectedCurrencies: [String] = []
    
    private let converter = CurrencyConverter()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Conversion Results"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Up to 4 labels for converted currencies
    private let convertedLabels: [UILabel] = {
        return (0..<4).map { _ in
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.isHidden = true
            return label
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        view.backgroundColor = .systemBackground
        setupUI()
        populateResults()
    }
    
    private func setupUI() {
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(titleLabel)
        view.addSubview(usdLabel)
        convertedLabels.forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            
            usdLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            usdLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            usdLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
        ])
        
        var lastBottom: NSLayoutYAxisAnchor = usdLabel.bottomAnchor
        for label in convertedLabels {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: lastBottom, constant: 16),
                label.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20)
            ])
            lastBottom = label.bottomAnchor
        }
    }
    
    private func populateResults() {
        usdLabel.text = "USD: \(usdAmount)"
        
        for (index, currencyCode) in selectedCurrencies.enumerated() {
            guard index < convertedLabels.count else { break }
            if let convertedAmount = converter.convert(usdAmount: usdAmount, to: currencyCode) {
                let formatted = String(format: "%@ %.2f", currencyCode, convertedAmount)
                convertedLabels[index].text = formatted
                convertedLabels[index].isHidden = false
            }
        }
    }
}

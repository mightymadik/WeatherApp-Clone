//
//  WeeklyItemView.swift
//  myWeather
//
//  Created by MacBook on 20.05.2023.
//

import UIKit

class WeeklytItemView: UIView {
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let stroke: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return view
    }()
    
    private let minTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 9)
        label.textColor = .white
        label.text = "Мин"
        return label
    }()
    
    private let maxTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 9)
        label.textColor = .white
        label.text = "Макс"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])

        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])

        addSubview(minTemperatureLabel)
        NSLayoutConstraint.activate([
            minTemperatureLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20)
        ])
        
        addSubview(stroke)
            NSLayoutConstraint.activate([
                stroke.heightAnchor.constraint(equalToConstant: 2),
                stroke.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 8),
                stroke.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor, constant: 3)
        ])

        addSubview(maxTemperatureLabel)
        NSLayoutConstraint.activate([
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: stroke.trailingAnchor, constant: 8),
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        addSubview(minTitleLabel)
        NSLayoutConstraint.activate([
            minTitleLabel.leadingAnchor.constraint(equalTo: stroke.leadingAnchor),
            minTitleLabel.bottomAnchor.constraint(equalTo: stroke.topAnchor, constant: -2)
        ])
        
        addSubview(maxTitleLabel)
        NSLayoutConstraint.activate([
            maxTitleLabel.trailingAnchor.constraint(equalTo: stroke.trailingAnchor),
            maxTitleLabel.centerYAnchor.constraint(equalTo: minTitleLabel.centerYAnchor)
        ])
    }
    
    func configure(model: WeeklyItemModel) {
        dayLabel.text = model.day
        minTemperatureLabel.text = model.minTemperature.withTemperature
        maxTemperatureLabel.text = model.maxTemperature.withTemperature
    }
}

//
//  DayForecastView.swift
//  myWeather
//
//  Created by MacBook on 02.06.2023.
//

import UIKit
import Kingfisher

class DayForecastView: UIView {

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
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
        label.textAlignment = .right
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let minTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 9)
        label.textColor = .white
        label.text = "мин"
        return label
    }()
    
    private let maxTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 9)
        label.textColor = .white
        label.text = "макс"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ForecastDayModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: model.date) {
            
            if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
                dayLabel.text = "Cегодня"
            } else {
                dayLabel.text = dateFormatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
            }
            
        }

        minTemperatureLabel.text = model.day.minTemperature.withCelcius
        maxTemperatureLabel.text = model.day.maxTemperature.withCelcius
        
        guard let url = URL(string: model.day.condition.iconURLPath) else { return }
        icon.kf.setImage(with: url)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
        
        addSubview(minTemperatureLabel)
        NSLayoutConstraint.activate([
            minTemperatureLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 8),
            lineView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor, constant: 3)
        ])
        
        addSubview(maxTemperatureLabel)
        NSLayoutConstraint.activate([
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8),
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        addSubview(minTitleLabel)
        NSLayoutConstraint.activate([
            minTitleLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            minTitleLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -2)
        ])
        
        addSubview(maxTitleLabel)
        NSLayoutConstraint.activate([
            maxTitleLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            maxTitleLabel.centerYAnchor.constraint(equalTo: minTitleLabel.centerYAnchor)
        ])
    }
}

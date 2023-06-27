//
//  ForecastItemView.swift
//  myWeather
//
//  Created by MacBook on 19.05.2023.
//

import UIKit
import Kingfisher

class ForecastItemView: UIView {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
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
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
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
        
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 4),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(model: ForecastHourModel) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: model.time) {
            dateFormatter.dateFormat = "HH"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH"
            let currentTime = timeFormatter.string(from: Date())
            
            timeLabel.text = currentTime == timeFormatter.string(from: date) ? "Сейчас" : dateFormatter.string(from: date)             
        }

        icon.image = UIImage(named: "clouds")

        temperatureLabel.text = model.currentTemperature.withCelcius
        
        guard let url = URL(string: model.condition.iconURLPath) else { return }
        icon.kf.setImage(with: url)
        
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH"
//        let nowTime = dateFormatter.string(from: Date())
//
//        guard var currentDay = cityModel.forecastDays.first else { return }
//        guard var currentHourIndex = currentDay.hour.firstIndex(where: {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//            guard let date = dateFormatter.date(from: $0.time) else { return false }
//            dateFormatter.dateFormat = "HH"
//            let loopTime = dateFormatter.string(from: date)
//            return loopTime == nowTime
//        }) else { return }
//
//        currentDay.hour[currentHourIndex].time = "Сейчас"
        
    }
}

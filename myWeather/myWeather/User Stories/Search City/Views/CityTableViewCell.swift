//
//  CityTableViewCell.swift
//  myWeather
//
//  Created by MacBook on 28.05.2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.blueMainBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    func configure(with city: SearchCityModel) {
        nameLabel.text = city.name
        regionLabel.text = city.region
        countryLabel.text = city.country
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        containerView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12)
        ])
        
        containerView.addSubview(regionLabel)
        NSLayoutConstraint.activate([
            regionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            regionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
        
        containerView.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -16),
            countryLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }
}

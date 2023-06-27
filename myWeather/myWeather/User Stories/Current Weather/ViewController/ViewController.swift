//
//  ViewController.swift
//  myWeather
//
//  Created by MacBook on 19.05.2023.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var backgroundForecastView: UIView!
    @IBOutlet weak var forecastStackView: UIStackView!
    @IBOutlet weak var weeklyForecastView: UIView!
    @IBOutlet weak var weeklyForecastStackView: UIStackView!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    
    private let dataSource: ForecastDataSource = .init()
    
    private var cityModel: CityModel? {
        didSet {
            configureUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundForecastView.backgroundColor = Color.blueBackgroundColor
        backgroundForecastView.layer.cornerRadius = 8
        
        weeklyForecastStackView.backgroundColor = Color.blueBackgroundColor
        weeklyForecastStackView.layer.cornerRadius = 8
        
        
        getData()
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        let viewController = CitiesViewController()
        viewController.navigationTitle = "Погода"
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func configureUI() {
        guard let cityModel = cityModel else { return }
        
        nameLabel.text = cityModel.name
        temperatureLabel.text = cityModel.currentTemperature.withCelcius
        conditionLabel.text = cityModel.condition.text
        
        guard let maxTemperature = cityModel.maxTemperature, let minTemperature = cityModel.minTemperature else { return }
        rangeLabel.text = "Макс.: \(maxTemperature.withCelcius), мин.: \(minTemperature.withCelcius)"
        
        weeklyForecastStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cityModel.forecastDays.forEach {
            let dayForecastView = DayForecastView()
            dayForecastView.configure(model: $0)
            weeklyForecastStackView.addArrangedSubview(dayForecastView)
        }
        configureCurrentHoursView()
    }
    
    private func getData() {
        dataSource.getForecast(cityName: cityModel?.name ?? "Almaty", days: 10) { result in
            switch result {
            case .success(let cityModel):
                DispatchQueue.main.async {
                    self.cityModel = cityModel
                }
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
    
    private func configureCurrentHoursView() {
        guard let cityModel = cityModel else { return }
        
        guard let currentDay = cityModel.forecastDays.first else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let nowTime = dateFormatter.string(from: Date())
        
        guard let currentHourIndex = currentDay.hour.firstIndex(where: {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let date = dateFormatter.date(from: $0.time) else { return false }
            dateFormatter.dateFormat = "HH"
            let loopTime = dateFormatter.string(from: date)
            return loopTime == nowTime
        }) else { return }
        
        let filteredHours = Array(currentDay.hour[currentHourIndex...])
        
        forecastStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        filteredHours.forEach {
            let forecastItemView = ForecastItemView()
            forecastItemView.configure(model: $0)
            forecastStackView.addArrangedSubview(forecastItemView)
        }
    }

    private func configureForecastView() {

    }
}

extension ViewController: CitiesViewControllerDelegate {
    func didSelectCity(_ city: SearchCityModel) {
        cityModel?.name = city.name
        getData()
    }
}

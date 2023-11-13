//
//  ViewController.swift
//  WeatherAPI
//
//  Created by arturs.olekss on 10/11/2023.
//

import UIKit
import Alamofire

class WeatherViewContoller: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
    
    let apiKey:String = "5eb699a248msh0f0f3ad674a8a11p108c15jsnce53d5ab2ac9"
    let apiHost:String = "weatherapi-com.p.rapidapi.com"
    let apiUrl:String = "https://weatherapi-com.p.rapidapi.com/current.json"
    let city: String = "Riga"
    
    var currentWeather: CurrentWeather?
    var condition: Condition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
    }
    
    func loadWeatherData(){
        let headers:[String:String] = ["X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": apiHost]
        let params:[String:String] = ["q":city]
        
        cityNameLabel.text = "Loading..."
        conditionLabel.text = "Loading..."
        tempLabel.text = "Loading..."
        feelsLikeTempLabel.text = "Loading..."
        
        AF.request(apiUrl,method: .get,parameters: params,headers: HTTPHeaders(headers)).responseDecodable(of:CurrentWeather.self){
            response in
            switch response.result{
            case .success(let value):
                self.currentWeather = value
                self.showData()
//                do{
//                    self.currentWeather = value
//                }
//                catch{
//                    print("error::::",error)
//                }
            case.failure(let error):
                print(error)
                self.cityNameLabel.text = "Error..."
                self.conditionLabel.text = "Error..."
                self.tempLabel.text = "Error..."
                self.feelsLikeTempLabel.text = "Error..."
            }
        }
    }
    
    func showData() {
        cityNameLabel.text = currentWeather?.location.name
        conditionLabel.text = condition?.text
        tempLabel.text = "\(currentWeather?.current.tempC ?? 0.0) ºC"
        feelsLikeTempLabel.text = "\(currentWeather?.current.feelslikeC ?? 0.0) ºC"
    }


}


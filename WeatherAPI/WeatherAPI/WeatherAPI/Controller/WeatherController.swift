//
//  ViewController.swift
//  WeatherAPI
//
//  Created by arturs.olekss on 10/11/2023.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewContoller: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var inputCity: UITextField!
    
    let apiKey:String = "5eb699a248msh0f0f3ad674a8a11p108c15jsnce53d5ab2ac9"
    let apiHost:String = "weatherapi-com.p.rapidapi.com"
    let apiUrl:String = "https://weatherapi-com.p.rapidapi.com/current.json"
    var location: String = ""
    
    var currentWeather: CurrentWeather?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        self.inputCity.text = location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if(location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            self.location = lat + "," + long
            self.loadWeatherData()
        }
    }
    
    @IBAction func getTemp(_ sender: Any) {
        
        guard let inputCityText = self.inputCity.text, !inputCityText.isEmpty else {
            let alertController = UIAlertController(title: "Text field is empty", message: "Please add a city to find out the weather", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        }
            
        self.location = self.inputCity.text!
        self.loadWeatherData()
        self.view.endEditing(true)
    }
    
    
    func loadWeatherData(){
        let headers:[String:String] = ["X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": apiHost]
        let params:[String:String] = ["q":self.location]
        
        tempLabel.text = "Loading..."
        feelsLikeTempLabel.text = "Loading..."
        
        AF.request(apiUrl,method: .get,parameters: params,headers: HTTPHeaders(headers)).responseDecodable(of:CurrentWeather.self){
            response in
            switch response.result{
            case .success(let value):
                
                self.currentWeather = value
                self.tempLabel.text = "Temperature: \(self.currentWeather?.current.tempC?.description ?? "...")" + " ºC"
                self.feelsLikeTempLabel.text = "Feels like: \(self.currentWeather?.current.feelslikeC?.description ?? "...")" + " ºC"
                self.inputCity.text = (self.currentWeather?.location.name ?? self.inputCity.text)

            case.failure(let error):
                print(error)
                self.tempLabel.text = "Error..."
                self.feelsLikeTempLabel.text = "Error..."
                self.displayErrorAlert(error: error)
            }
        }
    }
    
    func displayErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error", message: "An error occured: \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}


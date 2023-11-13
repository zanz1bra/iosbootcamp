//
//  ViewController.swift
//  WeatherAPI
//
//  Created by arturs.olekss on 10/11/2023.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewContoller: UIViewController,CLLocationManagerDelegate {
    
    let apiKey:String = "d239831fd9msh4ad7cb7ac973f08p13968ejsn70e9adc40ca5"
    let apiHost:String = "weatherapi-com.p.rapidapi.com"
    let apiUrl:String = "https://weatherapi-com.p.rapidapi.com/current.json"
    var location: String = "Riga"
    
    var currentWeather:CurrentWeather?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var inputCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //        self.inputCity.text = city
        //        loadWeatherData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if(location.horizontalAccuracy > 0){
            self.locationManager.stopUpdatingLocation()
            let long = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            self.location = lat + "," + long
            self.loadWeatherData()
        }
        
    }
    
    @IBAction func getTemperature(_ sender: Any) {
        self.location = self.inputCity.text!
        //        loadWeatherData()
    }
    
    
    func loadWeatherData(){
        let headers:[String:String] = ["X-RapidAPI-Key": apiKey,
                                       "X-RapidAPI-Host": apiHost]
        let params:[String:String] = ["q":self.location]
        AF.request(apiUrl,method: .get,parameters: params,headers: HTTPHeaders(headers)).responseDecodable(of:CurrentWeather.self){
            response in
            switch response.result{
            case .success(let value):
                
                self.currentWeather = value
                self.temperature.text = (self.currentWeather?.current.tempC?.description ?? "...") + " °C"
                self.inputCity.text = (self.currentWeather?.location.name ?? self.inputCity.text)
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

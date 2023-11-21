//
//  Country.swift
//  RestCountries
//
//  Created by arturs.olekss on 15/11/2023.
//

import Foundation


struct Name:Codable{
    let common,official:String?
}

struct Country:Codable{
    let name:Name
}

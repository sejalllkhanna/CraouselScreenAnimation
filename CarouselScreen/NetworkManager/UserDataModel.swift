//
//  DataModel.swift
//  CarouselScreen
//
//  Created by Apple on 23/11/21.
//


import Foundation
struct EvenUserData : Codable {
    var amountLabel: String?
    var dayLabel: String?
    var userNameLabel: String?

    init(amountLabel: String?, dayLabel: String?, userNameLabel: String?){
        self.amountLabel = amountLabel
        self.dayLabel = dayLabel
        self.userNameLabel = userNameLabel
    }

}
struct OddUserData : Codable {
    var amountLabel: String?
    var dayLabel: String?
    var userNameLabel: String?

    init(amountLabel: String?, dayLabel: String?, userNameLabel: String?){
        self.amountLabel = amountLabel
        self.dayLabel = dayLabel
        self.userNameLabel = userNameLabel
    }

}


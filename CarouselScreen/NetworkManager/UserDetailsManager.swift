//
//  GetDetails.swift
//  CarouselScreen
//
//  Created by Apple on 23/11/21.
//

//
import Foundation
import  UIKit
extension CarouselViewController {
    func getDetails() {
        let headers = [
            "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
            "x-rapidapi-key": "SIGN-UP-FOR-KEY"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://movie-database-imdb-alternative.p.rapidapi.com/?s=Avengers%20Endgame&r=json&page=1")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self] (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                self.showAnimatingDotsInImageView()
            }
        })
        dataTask.resume()
    }
    
}

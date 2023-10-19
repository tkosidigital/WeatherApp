//
//  APIManager.swift
//  WeatherApp
//
//  Created by rguttula on 06/03/21.
//

import Foundation
enum Response<T> {
    case success(T)
    case failure(Error?)
    case networkError(String)
}

struct APIManager {
    

    
    
    // MARK: - getRequest
    static func getRequest<T:Codable>(serverUrlStr: String,completion: @escaping(Response<T>) -> ())
    {
        
        guard let url = URL(string: serverUrlStr) else {
            return
        }
        
        let headers : [String:String] = [
            "Accept": "application/json",
            "Client":"mobile"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
    
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(6000)
        config.timeoutIntervalForResource = TimeInterval(6000)
        let urlSession = URLSession(configuration: config)
        
        let task = urlSession.dataTask(with: request) { data, response, error in

        //let task = urlSession.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                completion(.failure(error))
                return
            }
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if json?["error"] != nil{
                }
                else {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseData))
                }
            }
            catch let jsonErr {

                completion(.failure(jsonErr))
            }
        }
        task.resume()

    }
    
   
}

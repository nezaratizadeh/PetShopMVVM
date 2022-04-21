//
//  APIService.swift
//  jadidi
//
//  Created by Leila Nezaratizadeh on 20/04/2022.
//

import Foundation


class APIService :  NSObject {
    
    private let sourceURL = URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=sold")!
    
    func apiToGetEmployeeData(completion:@escaping ([Pet]) -> ()) {
        URLSession.shared.dataTask(with: sourceURL) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
                
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                                    
                    let decodedData = try JSONDecoder().decode([Pet].self,
                                                               from: prettyJsonData)
                
                
//                let jsoonDecoder = JSONDecoder()
//                let petData = try! jsoonDecoder.decode([Pet].self, from: data)
                completion(decodedData)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
        }.resume()
}
}

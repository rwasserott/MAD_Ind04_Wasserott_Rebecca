//
//  ApiService.swift
//  MAD_Ind04_Wasserott_Rebecca
//
//  Created by Rebecca Wasserott on 4/4/22.
//

import Foundation


class ApiService {
    
    
    
    private var dataTask: URLSessionDataTask?
    
    func getStateInfo(completion: @escaping (Result<[StatesResult], Error>) -> Void) {
        
        let statesInfoURL = "https://webmail.cs.okstate.edu/~rewasse/statesMAD.php"
        guard let url = URL(string: statesInfoURL)
        else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse
            else {
                print("Repsonse Empty")
                return
            }
            print("Repsonse code: \(response.statusCode)")
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                let jsonData: [StatesResult] = try decoder.decode([StatesResult].self, from: data)
                
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
    
            }
                
            }
            
            catch let error{
                completion(.failure(error))
            }
            
            }
        
            dataTask?.resume()
    }
}

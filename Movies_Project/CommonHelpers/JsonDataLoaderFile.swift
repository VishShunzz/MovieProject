//
//  JsonDataLoaderFile.swift
//  Movies_Project
//
//  Created by Vishal  on 07/09/24.
//

import Foundation


final class JsonDataLoaderFile {
    
    static let shared = JsonDataLoaderFile()
    
    private init() { }
    
    
    func loadJSONFromFile<T: Decodable>(_ fileName: String, type: T.Type) -> T? {
        // Get the file URL from the main bundle
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                // Load the data from the file
                let data = try Data(contentsOf: fileUrl)
                
                // Decode the JSON data into your model
                let model = try JSONDecoder().decode(T.self, from: data)
               return model
                
            } catch {
                debugPrint("Error reading or parsing the file: \(error)")
                return nil
            }
        } else {
            debugPrint("File not found")
            return nil
        }
    }

}

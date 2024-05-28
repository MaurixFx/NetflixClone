//
//  JSONReader.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 28-05-24.
//

import Foundation

final class JSONReader {
    static func readJSONFromFile<T: Codable>(fileName: String, fileType: String = "json", bundle: Bundle = .main) -> T? {
        guard let fileURL = bundle.url(forResource: fileName, withExtension: fileType) else {
            print("File not found: \(fileName).\(fileType)")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error reading or decoding file: \(error)")
            return nil
        }
    }
}

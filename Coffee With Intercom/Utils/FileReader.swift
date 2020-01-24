//
//  FileReader.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import Foundation

typealias CustomersResult = (_ customers: [Customer]) -> Void

class FileReader {
    
    init() {
    }
    
    func readCustomersFromRemoteFile(completion: @escaping CustomersResult) {
        let request = APIRequest(url: Endpoints.remoteCustomersFileUrl, method: .get)
        APIManager.request(request) { (response, headers, error) in
            var customers = [Customer]()
            if let customersData = response as? String {
                customers.append(contentsOf: self.parseCustomers(fileContents: customersData))
            }
            completion(customers)
        }
    }
    
    func readCustomersFromBundle(completion: @escaping CustomersResult) {
        var customers = [Customer]()
        if let filepath = Bundle.main.path(forResource: "customers", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath).trimmingCharacters(in: .whitespacesAndNewlines)
                customers.append(contentsOf: self.parseCustomers(fileContents: contents))
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
        completion(customers)
    }
    
    private func parseCustomers(fileContents: String) -> [Customer] {
        let customersStringArray = fileContents.components(separatedBy: .newlines)
        return customersStringArray.compactMap { (string) -> Customer? in
            if let customerJson = string.toJson() as? JSONObject {
                return customerJson.to(type: Customer.self, keyDecodingStartegy: .convertFromSnakeCase)
            }
            return nil
        }
    }
    
}

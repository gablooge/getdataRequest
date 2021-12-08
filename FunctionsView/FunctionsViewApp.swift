//
//  FunctionsViewApp.swift
//  FunctionsView
//
//  Created by Samsul Hadi on 08/12/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFunctions

@main
struct FunctionsViewApp: App {
    
    init() {
        print("AAAA")
        FirebaseApp.configure()
        getMethod()
//        let functions = Functions.functions()
//        functions.useEmulator(withHost: "http://localhost", port: 5001)
//        functions.httpsCallable("yoti-getSessions")
//            .call([]) { result, error in
//              if let error = error as NSError? {
//                if error.domain == FunctionsErrorDomain {
//                  let code = FunctionsErrorCode(rawValue: error.code)
//                  let message = error.localizedDescription
//                  let details = error.userInfo[FunctionsErrorDetailsKey]
//                }
//                  print("ERRRRRRRrrroor")
//                // ...
//              }
//                print(result)
//            }
//        .call { result, error in
//          if let error = error as NSError? {
//              print("ERRRRROORRRR")
//            if error.domain == FunctionsErrorDomain {
//              let code = FunctionsErrorCode(rawValue: error.code)
//              let message = error.localizedDescription
//              let details = error.userInfo[FunctionsErrorDetailsKey]
//              print("There was an error when trying to call the function. \n" +
//                      "Code: \(String(describing: code)) \n" +
//                      "Message: \(message) \n" +
//                      "Details: \(String(describing: details))")
//            }
//          }else{
//              print("SUKKSEESSSS")
//              print(result)
//          }
//        }
    }
    
    func getMethod() {
        print("Masok")
        guard let url = URL(string: "http://localhost:5001/fora-cryptocurrency/us-central1/yoti-getSessions") else {
            print("Error: cannot create URL")
            return
        }
        print("Masok2")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print ("Error: calling GET")
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
            print("=======")
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                print(jsonObject)
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                print(prettyJsonData)
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
            
            print(data)
        }.resume()
    }
    
        
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

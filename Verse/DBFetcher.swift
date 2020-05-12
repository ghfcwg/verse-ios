//
//  DBFetcher.swift
//  Verse
//
//  Created by George ChungWon Glass on 5/7/20.
//  Copyright © 2020 ghfcwg. All rights reserved.
//

import SwiftUI

public class DBFetcher: ObservableObject {
    //@Published var verse = [Verse]()
    @Published var verses = [VerseModel]()
    
    init() {
        verseSearch(query: "Forty")
    }

    func verseSearch(query: String) {
        //verse = [Verse]()
        
        /*let scheme = "https"
        let host = "chungwon.glass"
        let path = "/query"
        let queryItem = URLQueryItem(name: "q", value: query)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [queryItem]
        */
        let url = URL(string:  "https://chungwon.glass:8443/query?q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        print(url)
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) {(data,response,error) in
            do {
                if let d = data /*, let dataString = String(data: data!, encoding: .utf8)*/ {
                    print("Data successfully arrived, now decoding")
                    print ("The data are \(String(describing: data?.count)) characters long")
                    //print (dataString )
                    let decoder = JSONDecoder()
                    let decodedLists = try decoder.decode([VerseModel].self, from: d)
                    DispatchQueue.main.async {
                        self.verses = decodedLists
                    }
                    if decodedLists.isEmpty == false {
                        print("List was properly decoded to struct") //decodedLists[0])
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error: " + error.localizedDescription)
            }
            
        }.resume()
    }
}

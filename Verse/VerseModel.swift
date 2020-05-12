//
//  VerseModel.swift
//  VerseModel
//
//  Created by George ChungWon Glass on 5/7/20.
//  Copyright © 2020 ghfcwg. All rights reserved.
//

import SwiftUI
import Combine

struct VerseModel : Identifiable,Decodable {
    let id:String
    let content:String
    let title:String
    let reference:String
    let url:String
    let rating:Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "content"
        case title = "title"
        case reference = "reference"
        case url = "url"
        case rating = "rating"
     }
}


#if DEBUG

struct VerseView: View {
    @ObservedObject private var fetcher = DBFetcher()
    
    var body: some View {
        NavigationView {
            List(
                fetcher.verses
            ) { ver in
                Image(systemName: "photo")
                VStack(alignment: .leading) {
                    Text(ver.title)
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                    Text(ver.reference)
                    Text(ver.url)
                }
                .padding()
            }
            .navigationBarTitle(Text("Verses"))
        }
    }
}

#if DEBUG
struct VerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView()
    }
}
#endif

#endif

//
//  ContentView.swift
//  Verse
//
//  Created by George ChungWon Glass on 5/7/20.
//  Copyright © 2020 ghfcwg. All rights reserved.
//

import SwiftUI

/*private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()*/

struct ContentView: View {
    //@State private var dates = [Date]()
    @State private var searchStr: String = ""
    @ObservedObject public var fetcher = DBFetcher()
    
    var body: some View {

                /*TextField("Search...", text: $searchStr, onEditingChanged: { (changed) in
                 if changed {
                 print("text edit has begun")
                 } else {
                 print("committed the change")
                 self.fetcher.verseSearch(query: self.searchStr)
                 }
                 })
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                 Button("Search",action: {self.fetcher.verseSearch(query: self.searchStr)}
                 )*/
        VStack(alignment: .center, spacing: 0) {
            HStack {
                SearchBar(text: self.$searchStr, placeholder: "Search...",
                          prompt: "Enter speech search terms:",
                          fetcher: self.fetcher/*
                                print("committed the change")
                                self.fetcher.verseSearch(query: self.searchStr)
 */)
                Button(action: { } ) {
                        Text("Privacy")
                        .foregroundColor(Color.blue)
                }
            }
            NavigationView {
            MasterView(verses: fetcher.verses)
                .navigationBarTitle(Text("Verses"))
            DetailView(ver: VerseModel(id: "", content: "", title: "", reference: "", url: "", rating: 0))
                
            }
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    var prompt: String?
    var fetcher: DBFetcher

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var placeholder: String
        var prompt: String?
        var fetcher: DBFetcher

        init(text: Binding<String>, placeholder: String, prompt: String?, fetcher: DBFetcher) {
            _text = text
            self.placeholder = placeholder
            self.prompt = prompt
            self.fetcher = fetcher
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("textbox finished editing")
            self.fetcher.verseSearch(query: text)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, placeholder: self.placeholder, prompt: self.prompt, fetcher: self.fetcher)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = context.coordinator.placeholder
        searchBar.prompt = context.coordinator.prompt
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

/*
struct NavView: View {
    @ObservedObject var fetcher = DBFetcher()

    var body: some View {
        List(
        fetcher.verse
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
}*/

struct MasterView: View {
    var verses: [VerseModel]

    var body: some View {
        List (verses) { verse in
                NavigationLink(
                    destination: DetailView(ver: verse)
                ) {
                    VStack(alignment: .leading){
                        Text(verse.title + " " + verse.reference)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .lineLimit(5)
                        Text(verse.url)
                            .font(.footnote)
                            .fontWeight(.light)
                            .lineLimit(2)
                        Text(verse.content)
                            .lineLimit(10)
                            .padding(.top)
                    }
                }
            /*}.onDelete { indices in
                indices.forEach { self.dates.remove(at: $0) }
            }*/
        }
    }
}

struct DetailView: View {
    var ver: VerseModel //= Verse(id: "", content: "", title: "", reference: "", url: "", rating: 0)

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 2.0) {
                Text(ver.title + " " + ver.reference)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .padding([.leading, .bottom, .trailing])
                Text(ver.url)
                    .font(.footnote)
                    .padding([.leading, .bottom, .trailing])
                Text(ver.content)
                    .font(.body)
                    .padding(.horizontal)
            }
            .navigationBarTitle(ver.title + " " + ver.reference)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

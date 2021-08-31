//
//  ContentView.swift
//  Marvel
//
//  Created by Naveed Shaikh on 25/08/21.
//

import SwiftUI
import URLImage

struct ContentView: View {

    
    @State var root = [Results]()
    @State var comicItem = [ComicsItem]()
    
    var body: some View {
        
        ZStack {
            NavigationView {
                List(self.root) { marvelData in
                    CharacterCell(marvelData: marvelData)
                }
                .navigationBarTitle(Text("World Of Marvel"))
            }
        }
        .onAppear() {
            MarvelAPI().loadCharacters { (root) in
                self.root = root
                print(self.root)
                print(self.root.count)
               }
            }
        }
    }



struct CharacterCell: View {
    let marvelData: Results

    var body: some View {

        return NavigationLink(destination: CharacterDetail(name: marvelData.name, headline: marvelData.description, imageDict: marvelData.thumbnail, characterID: marvelData.id, comicList: marvelData.comics.items)) {
            let imgURL = MarvelAPI().characterImage(characterDetails: marvelData.thumbnail,size: "M");
                        
          // I dont have XCode13 yet so couldnt use Async Image
            URLImage(URL(string: imgURL)!) { image in
                image
                    .resizable().resizable().frame(width: 140, height: 140).cornerRadius(60.0).shadow(radius: 10)
                    .overlay(Circle().stroke(Color.red, lineWidth: 5))
            }
            VStack(alignment: .leading) {
                Text(marvelData.name)
                    .font(.largeTitle)
            }
        }
    }
}



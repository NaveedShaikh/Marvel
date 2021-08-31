//
//  CharacterDetail.swift
//  Marvel
//
//  Created by Naveed Shaikh on 26/08/21.
//

import SwiftUI
import URLImage

struct CharacterDetail: View {
    
    var name: String
    var headline: String
    var imageDict : Dictionary <String, String>
    var characterID:Int
    var comicList : [ComicsItem] 
   
    @State var comicDetails = [ComicDetailsWorld]()

    @State var isLoading:Bool = false

    
    var body: some View {
        VStack {
            let imgURL = MarvelAPI().characterImage(characterDetails: imageDict,size: "M");
            URLImage(URL(string: imgURL)!) { image in
                image
                    .resizable().resizable().frame(width: 140, height: 140).clipShape(Circle()).shadow(radius: 10)
                    .overlay(Circle().stroke(Color.red, lineWidth: 5))
            }                
                Text(headline)
                    .font(.subheadline)
                Divider()
            if self.isLoading {
                ProgressView()
                        .zIndex(1)
                }
            NavigationView {
            List(comicDetails) { marvelData in
                NavigationLink(destination: ComicsDetail(name: marvelData.title, id: characterID, thumbnailImage: marvelData.thumbnail, creatorsList: marvelData.creators.items)) {
                VStack{
                    Text(marvelData.title);
                    Spacer()
                    
                }
              }
            }
            .padding().navigationBarTitle(Text("Appeared in Comics"),displayMode: .inline)}
            //5
        }.padding().navigationBarTitle(Text(name), displayMode: .inline)
        .onAppear{
            
            MarvelAPI().loadComics(characterId: characterID, completion: { (comDet) in
                self.comicDetails = comDet
                print(self.comicDetails)
                print(self.comicDetails.count)
            })
        }
        
    }
}



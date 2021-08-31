//
//  ComicsDetail.swift
//  Marvel
//
//  Created by Naveed Shaikh on 29/08/21.
//

import SwiftUI
import URLImage

struct ComicsDetail: View {
    
    var name: String
    var id:Int
    var thumbnailImage : Dictionary <String, String>
    var creatorsList : [CreatorsItem]
    
    @State var comicDetails = [ComicDetailsWorld]()
    @State var creatorsListDisplay = [CreatorsItem]()


    var body: some View {
        
        VStack {

            let imgURL = MarvelAPI().characterImage(characterDetails: thumbnailImage,size: "L");
            URLImage(URL(string: imgURL)!) { image in
                image
                    .resizable().frame(width: 250, height: 156).shadow(radius: 10)
            }
                    //3
                    Text(name)
                        .font(.subheadline)
//            VStack {
//                    Text(String(id))
//                        .font(.title)
//            }
//            List(self.creatorsListDisplay) { marvelData in
//                VStack{
//                    Text(marvelData.name);
//                }
//            }
            
            List {
                        Section(header: ListHeader()) {
                            ForEach(self.creatorsListDisplay) { marvelData in
                                VStack{
                                    Text(marvelData.name);
                                }
                        }
                    }.listStyle(GroupedListStyle())
            
        }.onAppear{
            print(creatorsList)
            creatorsListDisplay = self.creatorsList
          }
        }
    }


    struct ListHeader: View {
        var body: some View {
            HStack {
                Text("Magic Creators")
            }
        }
    }
}

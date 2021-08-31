//
//  MarvelTypes.swift
//  Marvel
//
//  Created by Naveed Shaikh on 26/08/21.
//

import Foundation

let serverURL: String = Environment().configuration(PlistKey.ServerURL)


struct Root: Codable {
    let data: MarvelData
}
struct MarvelData: Codable {
    let results: [Results]
}

struct Comicroot: Codable {
    let data: MarvelComicData
}
struct MarvelComicData: Codable {
    let results: [ComicDetailsWorld]
}



struct Results: Codable, Identifiable {
    //let id = UUID()
    var id : Int
    var description: String
    var name: String
    var resourceURI: String

    let thumbnail: [String : String]
    let comics: Comics
}

struct ComicDetailsWorld: Codable, Identifiable {
    let id = UUID()
    var title: String
    var resourceURI: String
    let thumbnail: [String : String]
    let creators: Creators
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable, Identifiable {
    let id = UUID()
    let resourceURI: String
    let name: String
}


// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable, Identifiable {
    let id = UUID()
    let resourceURI: String
    let name: String
}



class MarvelAPI : ObservableObject{
    @Published var root = [Root]()
    
    func loadCharacters(completion:@escaping ([Results]) -> ()) {
        
        guard let url = URL(string: serverURL + "characters?ts=1&apikey=d2654e518b009945c17514a6adbce522&hash=f0a03fb82655bb9ac2f78bed925ab7ef") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let root = try? JSONDecoder().decode(Root.self, from: data!) {
                print("got", String(root.data.results.count), "Resultss")
                completion(root.data.results)
            }
                        
        }.resume()
        
    }
    
    func loadComics(characterId: Int, completion:@escaping ([ComicDetailsWorld]) -> ()) {
        
        guard let url = URL(string: serverURL + "characters/\(characterId)/comics?ts=1&apikey=d2654e518b009945c17514a6adbce522&hash=f0a03fb82655bb9ac2f78bed925ab7ef") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let root = try? JSONDecoder().decode(Comicroot.self, from: data!) {
                print("got", String(root.data.results.count), "Resultss")
                completion(root.data.results)
            }
                        
        }.resume()
    }
    
    // Create image of the thumbnail dict with extension and size of image
    func characterImage(characterDetails: Dictionary<String, String>, size:String) -> String {
       var imgURL = ""
         
        let path = characterDetails["path"]
        let sizeOfImage = size == "L" ? "landscape_amazing" : "standard_large"
        
        let ext = characterDetails["extension"]
        print(path!)
        imgURL = (path?.appending("/").appending(sizeOfImage).appending(".").appending(ext!))!
        print(imgURL)
        return imgURL;
    }
}





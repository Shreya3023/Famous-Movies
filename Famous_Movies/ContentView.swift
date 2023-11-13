//
//  ContentView.swift
//  Famous_Movies
//
//  Created by Shreya Prasad on 09/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct ContentView: View {
    @ObservedObject var obs = observer()
    var body: some View {
        NavigationView{
            List(obs.movie_list){ i in
    ListRow(url:i.poster_path,name: i.original_title,overviews : i.overview, date : i.release_date)
            }.navigationTitle("POPULAR MOVIES 🍿")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
class observer : ObservableObject{
    @Published var movie_list = [datatype2]()
    init() {
let url = "https://api.themoviedb.org/3/movie/popular?api_key=ddd4550b762b2511c91f4d584875f129&language=en-US&page=1"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) {
            (data, _,_) in
            do{
                let fetch = try  JSONDecoder().decode(datatype.self, from: data!)
                DispatchQueue.main.async {
                    self.movie_list = fetch.results
                }
            }
            
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
struct datatype :  Decodable {
    var results : [datatype2]
}
struct datatype2 : Identifiable, Decodable {
    var id : Int
    var original_title : String
    var poster_path : String
    var release_date: String
    var overview : String

  }
struct ListRow : View{
    var url = ""
var name = ""
    var overviews = ""
    var date = ""
    var body: some View{
        HStack{
AnimatedImage(url: URL(string : "https://image.tmdb.org/t/p/w500\(url)")).resizable().clipShape(RoundedRectangle(cornerRadius: 25.0)).frame(width : 150.0, height: 150.0)
        
            VStack{
                Text(name)
                    .fontWeight(.heavy)
                Text(overviews).lineLimit(4)
                Text(date).font(.title3)
            }
        }
    }
}

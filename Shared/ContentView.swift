//
//  ContentView.swift
//  Shared
//
//  Created by nic wanavit on 6/13/21.
//

import SwiftUI

struct ContentView: View {
    @State var id_:Int = 0
    
    var body: some View {
        Text("\(self.id_)")
            .padding()
        Button("get id", role: nil) {
            let newId = await self.getId()
            self.id_ = newId ?? 0
        }
    }
    
    
    func getId() async->Int? {
        do {
            let url:URL = URL(string: "https://api.github.com/users/hadley/orgs")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let res:SampleJson = try JSONDecoder().decode([SampleJson].self, from: data)[0]
            return res.id
        } catch {
            debugPrint("\(error)")
            return nil
        }
    }
}

struct SampleJson: Codable{
    let login: String
    let id: Int
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

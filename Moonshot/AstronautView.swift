//
//  AstronautView.swift
//  Moonshot
//
//  Created by Shane Donnelly on 23/09/2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Section(header: Text("Missions:")) {
                        ForEach(self.missions, id: \.id) { mission in
                            Text(" - \(mission.displayName)")
                        }
                        if self.missions.count == 0 {
                            Text(" - None")
                        }
                    }
                    .padding(.leading)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        self.missions = [Mission]()
        
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        for mission in allMissions {
            if let _ = mission.crew.first(where: { $0.name == self.astronaut.id }) {
                self.missions.append(mission)
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}

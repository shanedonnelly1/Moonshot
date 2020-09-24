//
//  ContentView.swift
//  Moonshot
//
//  Created by Shane on 20/09/2020.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isShowingLaunchDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text("\(mission.displayName)")
                            .font(.headline)
                        if self.isShowingLaunchDates {
                            Group {
                                Text(mission.formattedLaunchDate)
                            }
                        } else {
                            Group {
                                Text(mission.crewNames)
                            }
                        }
                    }
                }
                
            }
        .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $isShowingLaunchDates) {
                Text("Show Launch Dates")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

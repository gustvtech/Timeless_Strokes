// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct SecondMissionD1View: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Image("second_mission_d1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SecondMissionD2View()) {
                        Image("continue")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 25)
                    .padding(.bottom, -70)
                    .simultaneousGesture(TapGesture().onEnded {
                        playSound3()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func playSound3() {
        if let soundURL = Bundle.main.url(forResource: "proceed_sound_effect", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error 404: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    SecondMissionD1View()
}

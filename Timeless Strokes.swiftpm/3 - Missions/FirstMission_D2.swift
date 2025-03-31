// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct FirstMissionD2View: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Image("first_mission_d2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: FirstCanvasView()) {
                        Image("letsgo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 60)
                    .padding(.bottom, -20)
                    .simultaneousGesture(TapGesture().onEnded {
                        playSound2()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func playSound2() {
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
    FirstMissionD2View()
}

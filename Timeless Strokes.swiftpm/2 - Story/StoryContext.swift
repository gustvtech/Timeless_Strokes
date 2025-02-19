// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct StoryContextView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: FirstMissionView()) {
                            Image("letsgo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 50)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func playSound() {
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


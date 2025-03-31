// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct StoryContextD2View: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("story_context_d2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: FirstMissionD1View()) {
                            Image("letsgo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 63)
                        .padding(.bottom, -20)
                        .simultaneousGesture(TapGesture().onEnded {
                            playSound8()
                        })
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func playSound8() {
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
    StoryContextD2View()
}

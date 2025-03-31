// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct ThanksMessageView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Image("thanks")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: FinalMessageView()) {
                        Image("ok")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, -25)
                    .padding(.bottom, -60)
                    .simultaneousGesture(TapGesture().onEnded {
                        playSound10()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func playSound10() {
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
    ThanksMessageView()
}


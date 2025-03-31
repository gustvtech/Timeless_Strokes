// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct FinalMessageView: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Image("final_message")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                NavigationLink(destination: MenuView()) {
                    Image("return_to_menu")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .shadow(radius: 5)
                }
                .padding(.bottom, -80)
                .simultaneousGesture(TapGesture().onEnded {
                    playSound9()
                })
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    func playSound9() {
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
    FinalMessageView()
}

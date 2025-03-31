// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct LogoView: View {
    @State private var player: AVAudioPlayer?
    @State private var isActive = false
    @State private var isFadingOut = false

    func playSound() {
        if let url = Bundle.main.url(forResource: "logo_music", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error loading audio: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found.")
        }
    }
    
    var body: some View {
        NavigationStack {
            if isActive {
                WarningView()
                    .transition(.opacity)
            } else {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .opacity(isFadingOut ? 0 : 1)
                        .animation(.easeInOut(duration: 1.0), value: isFadingOut)
                }
                .onAppear {
                    playSound()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isFadingOut = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LogoView()
}

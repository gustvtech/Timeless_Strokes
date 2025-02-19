// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

class AudioManager {
    @MainActor static let shared = AudioManager()
    var player: AVAudioPlayer?
    var buttonPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "menu_music", withExtension: "mp3") else {
            print("Music file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        player?.stop()
        player = nil
    }
    
    func playButtonSound() {
        guard let url = Bundle.main.url(forResource: "buttons_sound_effect", withExtension: "mp3") else {
            print("Button sound file not found")
            return
        }
        
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: url)
            buttonPlayer?.play()
        } catch {
            print("Error playing button sound: \(error.localizedDescription)")
        }
    }
}

struct MenuView: View {
    @State private var isNavigatingToStoryContext = false
    @State private var isNavigatingToAbout = false
    @State private var isFadingOut = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        AudioManager.shared.playButtonSound()
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isFadingOut = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isNavigatingToStoryContext = true
                        }
                    }) {
                        Image("start")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .opacity(isFadingOut ? 0 : 1)
                            .animation(.easeInOut(duration: 1.0), value: isFadingOut)
                    }
                    .background(
                        NavigationLink("", destination: StoryContextView(), isActive: $isNavigatingToStoryContext)
                            .opacity(0)
                    )
                    
                    Spacer().frame(height: 100)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            AudioManager.shared.playButtonSound()
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isFadingOut = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                isNavigatingToAbout = true
                            }
                        }) {
                            Image("about")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150) 
                        }
                        .opacity(isFadingOut ? 0 : 1)
                        .animation(.easeInOut(duration: 1.0), value: isFadingOut)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                        .background(
                            NavigationLink("", destination: AboutView(), isActive: $isNavigatingToAbout)
                                .opacity(0)
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                AudioManager.shared.playBackgroundMusic()
            }
            .onDisappear {
                AudioManager.shared.stopBackgroundMusic()
            }
            .onChange(of: isNavigatingToStoryContext) { _ in
                isFadingOut = false
            }
            .onChange(of: isNavigatingToAbout) { _ in
                isFadingOut = false
            }
        }
    }
}

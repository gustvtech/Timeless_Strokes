// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import AVFoundation

struct StoryContextD1View: View {
   @State private var audioPlayer: AVAudioPlayer?
   
   var body: some View {
       NavigationStack {
           ZStack {
               Image("story_context_d1")
                   .resizable()
                   .scaledToFill()
                   .edgesIgnoringSafeArea(.all)
               
               VStack {
                   Spacer()
                   
                   HStack {
                       Spacer()
                       
                       NavigationLink(destination: StoryContextD2View()) {
                           Image("continue")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 300)
                               .shadow(radius: 5)
                       }
                       .padding(.trailing, 25)
                       .padding(.bottom, -70)
                       .simultaneousGesture(TapGesture().onEnded {
                           playSound7()
                       })
                   }
               }
           }
           .navigationBarBackButtonHidden(true)
       }
   }
   
   func playSound7() {
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
   StoryContextD1View()
}

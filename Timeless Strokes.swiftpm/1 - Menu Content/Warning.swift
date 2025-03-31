// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI

struct WarningView: View {
    @State private var isActive = false
    @State private var isFadingOut = false
    
    var body: some View {
        NavigationStack {
            if isActive {
                MenuView()
                    .transition(.opacity)
            } else {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("warning")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .opacity(isFadingOut ? 0 : 1)
                        .animation(.easeInOut(duration: 1.0), value: isFadingOut)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    WarningView()
}

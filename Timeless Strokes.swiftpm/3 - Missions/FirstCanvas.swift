// Code made by Gustavo Rocha (@gustvtech) in Rio de Janeiro, Brazil - 2025

import SwiftUI
import PencilKit
import AVFoundation

class AudioManagerC1: ObservableObject {
    @MainActor static let shared = AudioManagerC1()
    var player: AVAudioPlayer?
    var buttonPlayer: AVAudioPlayer?
    
    func playBackgroundMusicC1() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            guard let url = Bundle.main.url(forResource: "beach_ambience", withExtension: "mp3") else {
                print("Music file not found")
                return
            }
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("Error setting up audio or playing music: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        player?.stop()
        player = nil
    }
    
    func playButtonSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            guard let url = Bundle.main.url(forResource: "buttons_sound_effect", withExtension: "mp3") else {
                print("Button sound file not found")
                return
            }
            
            buttonPlayer = try AVAudioPlayer(contentsOf: url)
            buttonPlayer?.play()
        } catch {
            print("Error playing button sound: \(error.localizedDescription)")
        }
    }
}

class CustomCanvasView: PKCanvasView {
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

struct PKToolPickerRepresentable: UIViewRepresentable {
    @Binding var canvas: CustomCanvasView
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        setupToolPicker()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        setupToolPicker()
    }
    
    private func setupToolPicker() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        if let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            toolPicker.overrideUserInterfaceStyle = .dark
            
            let inkingTool = PKInkingTool(.pen, color: .black, width: 30)
            canvas.tool = inkingTool
            
            DispatchQueue.main.async {
                canvas.becomeFirstResponder()
            }
        }
    }
}

struct Home: View {
    @State var canvas = CustomCanvasView()
    @State private var isNavigatingToSecondMission = false
    @State private var isFadingOut = false
    @State private var imageSize: CGSize = .zero
    
    init() {
        _canvas = State(initialValue: {
            let canvas = CustomCanvasView()
            canvas.drawingPolicy = .anyInput
            canvas.backgroundColor = .clear
            return canvas
        }())
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        DrawingView(canvas: $canvas, imageSize: $imageSize, viewSize: geometry.size)
                            .background(
                                Image("beach_background")
                                    .resizable()
                                    .scaledToFit()
                                    .background(GeometryReader { imageGeometry in
                                        Color.clear
                                            .onAppear {
                                                imageSize = imageGeometry.size
                                            }
                                    })
                            )
                            .onAppear {
                                DispatchQueue.main.async {
                                    canvas.becomeFirstResponder()
                                }
                            }
                    }
                    .background(Color.black)
                    
                    VStack(spacing: 0) {
                        PKToolPickerRepresentable(canvas: $canvas)
                            .frame(height: 44)
                            .background(Color.black.opacity(0.9))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Finish button tapped")
                                AudioManagerC1.shared.playButtonSound()
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isFadingOut = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    isNavigatingToSecondMission = true
                                }
                            }) {
                                Image("finish")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 200)
                                    .opacity(isFadingOut ? 0 : 1)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.trailing, 0)
                            .padding(.vertical, -60)
                        }
                        .background(Color.black.opacity(0.9))
                    }
                    
                    NavigationLink(
                        destination: SecondMissionD1View(),
                        isActive: $isNavigatingToSecondMission
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Draw a sandcastle and a dolphin jumping!")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: CustomCanvasView
    @Binding var imageSize: CGSize
    let viewSize: CGSize
    
    func makeUIView(context: Context) -> CustomCanvasView {
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        canvas.overrideUserInterfaceStyle = .dark
        
        let maskLayer = CAShapeLayer()
        updateMaskLayer(maskLayer, for: canvas)
        canvas.layer.mask = maskLayer
        
        return canvas
    }
    
    func updateUIView(_ uiView: CustomCanvasView, context: Context) {
        if let maskLayer = uiView.layer.mask as? CAShapeLayer {
            updateMaskLayer(maskLayer, for: uiView)
        }
    }
    
    private func updateMaskLayer(_ maskLayer: CAShapeLayer, for canvas: PKCanvasView) {
        let imageAspectRatio = imageSize.width / imageSize.height
        let viewAspectRatio = viewSize.width / viewSize.height
        
        var drawingRect: CGRect
        
        if imageAspectRatio > viewAspectRatio {
            let height = viewSize.width / imageAspectRatio
            let y = (viewSize.height - height) / 2
            drawingRect = CGRect(x: 0, y: y, width: viewSize.width, height: height)
        } else {
            let width = viewSize.height * imageAspectRatio
            let x = (viewSize.width - width) / 2
            drawingRect = CGRect(x: x, y: 0, width: width, height: viewSize.height)
        }
        
        let path = UIBezierPath(rect: drawingRect)
        maskLayer.path = path.cgPath
    }
}

struct FirstCanvasView: View {
    var body: some View {
        Home()
            .ignoresSafeArea()
            .onAppear {
                AudioManagerC1.shared.playBackgroundMusicC1()
            }
            .onDisappear {
                AudioManagerC1.shared.stopBackgroundMusic()
            }
            .preferredColorScheme(.dark)
    }
}

#Preview {
    FirstCanvasView()
}

import SwiftUI
import Photos

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}

struct ContentView: View {
    @State private var fishList = [Fish(id: UUID()), Fish(id: UUID())]
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            ForEach(fishList, id: \.id) { fish in
                FishView(fish: fish, onTapGesture: { tappedFish in
                    fishList.removeAll(where: { $0.id == tappedFish.id })
                })
            }
        }
        .onTapGesture {
            addFish()
        }
    }
    
    func addFish() {
        let newFish = Fish(id: UUID())
        fishList.append(newFish)
    }
}

struct Fish: Identifiable {
    let id: UUID
    var position: CGPoint = CGPoint(x: 100, y: 100)
}

struct FishView: View {
    @State var fish: Fish
    let onTapGesture: (Fish) -> Void
    
    var body: some View {
        Image(systemName: "fish.fill")
            .foregroundColor(.orange)
            .frame(width: 50, height: 50)
            .position(fish.position)
            .onTapGesture {
                onTapGesture(fish)
            }
            .animation(.easeInOut(duration: 2).repeatForever())
            .onAppear {
                withAnimation {
                    fish.position = randomPosition()
                }
            }
    }
    
    private func randomPosition() -> CGPoint {
        let x = CGFloat.random(in: 50...350)
        let y = CGFloat.random(in: 100...400)
        return CGPoint(x: x, y: y)
    }
}

struct chagn: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

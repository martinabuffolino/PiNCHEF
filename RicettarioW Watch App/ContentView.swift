import SwiftUI

struct ContentView: View {
    
    @StateObject private var watchConnector: WatchConnector = WatchConnector()
    
    var body: some View {
        VStack {
            Text("Hello, \(watchConnector.testo)")
        }
    }
}

#Preview {
    ContentView()
}

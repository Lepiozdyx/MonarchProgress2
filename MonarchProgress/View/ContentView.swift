import SwiftUI

struct ContentView: View {
    
    @StateObject private var manager = AppStateManager()
        
    var body: some View {
        Group {
            switch manager.appState {
            case .request:
                LoadingView()
                
            case .support:
                if let url = manager.networkManager.monarchURL {
                    WKWebViewManager(
                        url: url,
                        webManager: manager.networkManager
                    )
                } else {
                    WKWebViewManager(
                        url: NetworkManager.iURL,
                        webManager: manager.networkManager
                    )
                }
                
            case .loading:
                ContentRootView()
                    .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            manager.stateRequest()
        }
    }
}

#Preview {
    ContentView()
}

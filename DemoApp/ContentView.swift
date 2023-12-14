import Foundation
import SwiftUI
import TrustPaySDK

struct ContentView: View {
    @EnvironmentObject var model: ContentViewModel
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(tag: ContentViewModel.PageSelection.resultPage, selection: $model.currentPage, destination: {
                    ResultView(model: model)
                }, label: { EmptyView() })
                NavigationLink(tag: ContentViewModel.PageSelection.processPage, selection: $model.currentPage, destination: {
                        model.paymentResponse?.getGatewayView(redirectUrl: "https://search.p3k.sk/search", closeFunction: setParamsAndShowResult)
                }, label: { EmptyView() })
                SetupView(model: model)
            }.alert(isPresented: $model.showAtert, content: {
                Alert(title: Text("Error occurred."), message: Text(model.altertText))
            })
            .padding()
        }
    }
    
    func setParamsAndShowResult(result: RedirectParameters) {
        model.redirectParameters = result
        model.paymentResponse = nil
        model.currentPage = .resultPage
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentViewModel())
}

import Foundation
import TrustPaySDK

class ContentViewModel: ObservableObject {
    @Published var showAtert: Bool = false
    @Published var altertText: String = ""
    @Published var currentPage: PageSelection?
    
    @Published var paymentResponse: PaymentResponse?
    @Published var redirectParameters: RedirectParameters?
    
    public enum PageSelection {
        case paymentPage, gettingUrl, processPage, resultPage
    }
}

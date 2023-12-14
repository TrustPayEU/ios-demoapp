import Foundation
import SwiftUI
import TrustPaySDK

// TODO
/*
@available(iOS 15.0, *)
struct ContentViewAsync: View {
    @State var isButtonDisabled: Bool = false
    @State var amount: String = "10.00"
    @State var currency: String = "EUR"
    @State var reference: String = "TestReference123"

    @State var showAtert: Bool = false
    @State var altertText: String = ""
    
    @State var redirectParameters: RedirectParameters? = nil
    
    @State var urlPrepared: Bool = false
    @State var url: URL? = nil
    
    @State var selection: Selection? = .paymentPage
    
    var tokenProvider = TokenProvider(projectId: "test", secret: "test")
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(tag: Selection.resultPage, selection: $selection, destination: { ResultView(redirectParameters: $redirectParameters) }, label: { EmptyView() })
                TextField("Amount", text: $amount)
                    .frame(width: 150)
                    .keyboardType(.decimalPad)
                TextField("Currency", text: $currency)
                    .frame(width: 150)
                TextField("Reference", text: $reference)
                    .frame(width: 150)
                
                if selection == .gettingUrl {
                    ProgressView()
                }
                Button(action: {
                    handlePay()
                }, label: {
                    Text("Pay")
                }).disabled(selection == .gettingUrl)
                    /*.sheet(isPresented: $urlPrepared, content: {
                        if url != nil {
                            SafariView(initialUrl: url, redirectUrl: "https://search.p3k.sk/search", closeFunction: {
                                (result) in
                                redirectParameters = result
                                urlPrepared = false
                                selection = .resultPage
                            })
                        }
                    })*/
            }.alert(isPresented: $showAtert, content: {
                Alert(title: Text("Error occurred."), message: Text(altertText))
            })
            .padding()
        }
    }
    
    func handlePay() {
        selection = .gettingUrl
        let amountDecimal = Decimal(string: amount)!
        let request = WireRequest(merchantIdentification: MerchantIdentification(projectId: "4107642030"),
                                  paymentInformation: PaymentInformation(
                                    amount: AmountWithCurrency(amount: amountDecimal, currency: currency),
                                    references: References(merchantRefenence: reference),
                                    localization: "SK", country: "SK"),
                                  callbackUrls: nil)
        Task {
            let response = await request.createPaymentRequestAsync(tokenProvider: tokenProvider)
            switch response {
            case .success(let preparedUrl):
            DispatchQueue.main.async {
                    if let validUrl = URL(string: preparedUrl) {
                        url = validUrl
                        urlPrepared = true
                    } else {
                        print("Invalid URL: \(preparedUrl)")
                    }
                }
            case .failure(let error):
               showError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        switch error {
        case let tpError as TpApiError:
            altertText = tpError.additionalInfo
        default:
            altertText = error.localizedDescription
        }
        
        selection = .paymentPage
        showAtert = true
    }
    
    enum Selection {
        case paymentPage, gettingUrl, processPage, resultPage
    }
}

#Preview {
    
    if #available(iOS 15.0, *) {
        ContentViewAsync()
    } else {
        ContentView()
    }
}

*/

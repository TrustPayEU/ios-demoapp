import Foundation
import SwiftUI
import TrustPaySDK

struct SetupView: View {
    @StateObject var model: ContentViewModel
    
    @State var amount: String = formatNumber(amount: Double.random(in: 0.01...999.99))
    @State var currency: String = "EUR"
    @State var reference: String = "TestReference\(Int.random(in: 100...999))"
    @State var paymentMethod: PaymentMethods = .wire
    
    var tokenProvider = TokenProvider(projectId: "test", secret: "test")
    
    var body: some View {
        VStack {
            Picker(selection: $paymentMethod, label: Text("Payment Method")) {
                Text("Wire").tag(PaymentMethods.wire)
                Text("Card").tag(PaymentMethods.card)
            }.frame(width: 150)
            TextField("Amount", text: $amount)
                .frame(width: 150)
                .keyboardType(.decimalPad)
            TextField("Currency", text: $currency)
                .frame(width: 150)
            TextField("Reference", text: $reference)
                .frame(width: 150)
            
            if model.currentPage == .gettingUrl {
                ProgressView()
            }
            Button(action: {
                model.currentPage = .gettingUrl
                handlePay()
            }, label: {
                Text("Pay")
            }).disabled(model.currentPage == .gettingUrl)
        }
    }
    
    func handlePay() {
        DispatchQueue.main.async {
            let amountDecimal = Decimal(string: amount)!
            let request: BaseRequest =
            switch paymentMethod {
            case .wire:
                WireRequest(merchantIdentification: MerchantIdentification(projectId: "4107642030"),
                            paymentInformation: PaymentInformation(
                                amount: AmountWithCurrency(amount: amountDecimal, currency: currency),
                                references: References(merchantRefenence: reference),
                                localization: "SK", country: "SK"),
                            callbackUrls: nil)
            case .card:
                CardRequest(merchantIdentification: MerchantIdentification(projectId: "4107642030"),
                            paymentInformation: PaymentInformation(
                                amount: AmountWithCurrency(amount: amountDecimal, currency: currency),
                                references: References(merchantRefenence: reference),
                                localization: "SK", country: "SK"), cardTransaction: CardTransaction(paymentType: CardPaymentType.purchase),
                            callbackUrls: nil)
            }
                
            request.createPaymentRequest(tokenProvider: tokenProvider, completion: saveResponseAndSwitchCurrentPage)
        }
    }
    
    func saveResponseAndSwitchCurrentPage(result: Result<PaymentResponse, Error>) {
        DispatchQueue.main.async {
            switch(result) {
            case .success(let wireResponse):
                model.paymentResponse = wireResponse
                model.currentPage = .processPage
            case .failure(let error as TpApiError):
                model.altertText = error.additionalInfo
                model.showAtert = true
                model.currentPage = .paymentPage
            case .failure(let error):
                model.altertText = error.localizedDescription
                model.showAtert = true
                model.currentPage = .paymentPage
            }
        }
    }
    
    static func formatNumber(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter.string(from: amount as NSNumber) ?? ""
    }
    
    enum PaymentMethods {
        case wire, card
    }
}

#Preview {
    SetupView(model: ContentViewModel())
}

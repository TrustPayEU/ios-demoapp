import SwiftUI
import TrustPaySDK

struct ResultView: View {
    @StateObject var model: ContentViewModel
    
    var body: some View {
        VStack {
            if model.redirectParameters != nil {
                Text(String(model.redirectParameters!.paymentRequestId!))
                Text(model.redirectParameters!.reference!)
            }
        }
    }
}

#Preview {
    @State var model = ContentViewModel()
    model.redirectParameters = RedirectParameters(url: "", paymentRequestId: 123456, reference: "Reference")
    return ResultView(model: model)
}


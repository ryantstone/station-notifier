import SwiftUI
import Combine

struct SearchField : View {

    @ObjectBinding var searchWrapper: SearchWrapper
    let placeHolder: String

    var body: some View {
        return HStack(alignment: .center, spacing: 0) {
            TextField($searchWrapper.searchText, placeholder: Text(verbatim: placeHolder))
                .textFieldStyle(.roundedBorder)
                .padding(.leading)
                .padding(.trailing)
        }
    }
}

//#if DEBUG
//struct SearchField_Previews : PreviewProvider {
//    static var previews: some View {
////        SearchField(searchWrapper: SearchWrapper(),
////                    placeHolder: "Search Text")
//    }
//}
//#endif

class SearchWrapper: BindableObject {
    var willChange = PassthroughSubject<SearchWrapper, Never>()
    @Published var searchText = ""
    private var cancellableSubscriber: Cancellable?
    
    init() {
        cancellableSubscriber = willChange
            .eraseToAnyPublisher()
            .map { $0.searchText }
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { value in
                DispatchQueue.main.async {
                    self.searchText = value
                }
            })
    }
}

import SwiftUI
import Combine
import Foundation
import ZIPFoundation

struct TitledView: View {
    let title: String
    @State var subTitle: String
    let action: () -> Void
    @State private var isSelected = false
    @State var published: AnyCancellable!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.capitalized)
                .foregroundColor(.black)
                .fontWeight(.black)
                .font(.system(size: 40))
            Button(action: didTap, label: {
                Text(subTitle)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .foregroundColor(.white)
                    .background(isSelected ? Color.green : Color.blue)
                    .cornerRadius(7)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 3, x: 0, y: 0)
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
            })
        }
    }
    
    private func didTap() {
        action()
        isSelected.toggle()
    }

    func getType(from text: String) {
        
    }
    
    func updateButtonText(_ text: String) {
        subTitle = text
    }
}

#if DEBUG
struct TitledView_Previews: PreviewProvider {
    static var previews: some View {
        TitledView(title: "Start", subTitle: "Deerfield Beach Station", action: {})
    }
}
#endif

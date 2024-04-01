import SwiftUI

struct CircleButtonView: View {
    let nameOfIcon: String
    var body: some View {
        Image(systemName: nameOfIcon)
            .foregroundColor(Color.accent)
            .frame(width: 75, height: 75)
            .background(
                Circle()
                    .foregroundColor(Color.circle)
                    .opacity(0.8)
            )
            .shadow(color: Color.accent.opacity(0.25) , radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
            .padding()
        
        
    }
}

#Preview {
    Group{
        CircleButtonView(nameOfIcon: "arrow.clockwise.circle")
        CircleButtonView(nameOfIcon: "arrow.clockwise.circle")
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
        
    }
}

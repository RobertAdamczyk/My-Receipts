//
//  NavigationTopBar.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 26.05.21.
//

import SwiftUI

struct NavigationTopBar: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.presentationMode) var presentation
    var title: String
    var backButton: Bool
    var body: some View {
        RoundedCorner(radius: 25)
            .fill(LinearGradient(
                    gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.8901960849761963, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                    startPoint: UnitPoint(x: 0.19333327563353553, y: 0.4042556636181329),
                    endPoint: UnitPoint(x: 1.0879999879773539, y: 3.260638766212674)))
            .frame(height: 54 + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .shadow(color: Color("ShadowColor"), radius:8, x:0, y:0)
            .overlay(
                Text("\(title)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
                , alignment: .bottom
            )
            .overlay(
                Button(action:{
                    if !backButton{
                        withAnimation{
                            homeViewModel.showMenuBar.toggle()
                        }
                    }else{
                        presentation.wrappedValue.dismiss()
                    }
                    
                }){
                    Text(Image(systemName: backButton ? "chevron.backward" : "line.horizontal.3"))
                        .font(.title2)
                        .padding(23)
                }
                .disabled(homeViewModel.showMenuBar)
                ,alignment: .bottomLeading
            )
    }
}

struct NavigationTopBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTopBar(title: "Home", backButton: false)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

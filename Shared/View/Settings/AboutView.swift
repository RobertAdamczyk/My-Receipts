//
//  AboutView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.06.21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form{
            Section{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
            }
            Section{
                VStack(spacing: 5){
                    HStack{
                        Text("Version:")
                        Text("1.0.0").bold()
                    }
                    HStack{
                        Text("Created by:")
                        Text("Robert Adamczyk").bold()
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .font(.subheadline)
            }
            Section{
                VStack(spacing: 20){
                    Text("Thanks for using my application. \n❤️❤️❤️")
                        
                    Text("If you like it, leave a review on the AppStore.")
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
        }
        .navigationBarTitle("About", displayMode: .inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AboutView()
                .navigationBarTitle("About", displayMode: .inline)
        }
    }
}

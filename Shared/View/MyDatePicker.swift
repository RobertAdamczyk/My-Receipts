//
//  DataPicker.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct MyDatePicker: View {
    @Binding var date: Date
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .background(
                RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color("Grey"))
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color("Light")))
            )
            .padding()
    }
}

struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        MyDatePicker(date: .constant(Date()))
    }
}

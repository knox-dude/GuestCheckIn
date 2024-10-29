//
//  ContentView.swift
//  GuestCheckIn
//
//  Created by Andrew Knox on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var date: Date = Date()
    @State private var name: String = ""
    @State private var destination: String = ""
    @State private var initials: String = ""
    @State private var company: String = ""
    @State private var timeIn: String = ""
    @State private var timeOut: String = ""
    
    func checkInGuest() {
        guard let url = URL(string: "https://backend.com/checkin") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // get string representation of date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let checkInDate = dateFormatter.string(from: date)
        
        // aggregate data for sending to backend
        let guestData = ["name":name, "date":checkInDate, "destination":destination, "company":company] as [String : String]
        request.httpBody = try? JSONSerialization.data(withJSONObject: guestData)
        let task = URLSession.shared.dataTask(with:request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            // Handle response here - not neccessary for now right?
        }
        
        task.resume()
    }
    
    
    var body: some View {
        VStack {
            Text("Guest Check-In")
                .font(.largeTitle)
                .padding()
            
            // Guest Name
            HStack {
                Text("Name:")
                    .frame(width: 100, alignment: .leading)
                    .padding()
                
                TextField("Example Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // Guest Destination
            HStack {
                Text("Destination:")
                    .frame(width: 100, alignment: .leading)
                    .padding()
                
                TextField("Example Destination", text: $destination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // Guest Company
            HStack {
                Text("Company:")
                    .frame(width: 100, alignment: .leading)
                    .padding()
                
                TextField("Example Company", text: $company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            // Submit Button
            Button(action: {
                // Handle Submission
                print("Variables: \(name), \(destination), \(company)")
            }) {
                Text("Check In")
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

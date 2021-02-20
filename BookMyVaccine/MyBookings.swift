//
//  MyBookings.swift
//  BookMyVaccine
//
//  Created by Aviral Yadav on 20/02/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MyBookings: View {
    //@Binding var isBooked : Bool
    //@State var myString : String
    
    let context=CIContext()
    let filter=CIFilter.qrCodeGenerator()
    var body: some View {
        ScrollView(.vertical){
            VStack{
                Text("MY BOOKINGS")
                    .fontWeight(.heavy)
                    .padding(20)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                VStack{
                    Text("MY VENUE/HOSPITAL NAME")
                        .fontWeight(.heavy)
                        .frame(width: 210, height: 30, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(16)
                    Text("NEW GENERAL HOSPITAL")
                        .fontWeight(.bold)
                        .padding(10)
                }.padding(20)
                VStack{
                    Text("MY TIME SLOT")
                        .fontWeight(.heavy)
                        .frame(width: 210, height: 30, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(16)
                    Text("2-2:15 PM")
                        .fontWeight(.bold)
                        .padding(10)
                }.padding(20)
                
                Text("CONTACTLESS QR CODE")
                    .fontWeight(.heavy)
                    .frame(width: 210, height: 30, alignment: .center)
                .foregroundColor(.white)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(16)
                Image(uiImage: generateQRCode(from: "Sample"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height:200)
                Spacer()
                
            }
        }
            
        
    }
    func generateQRCode(from string: String)->UIImage{
        let data = Data(string.utf8)
            filter.setValue(data, forKey: "inputMessage")

            if let outputImage = filter.outputImage {
                if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }

            return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}


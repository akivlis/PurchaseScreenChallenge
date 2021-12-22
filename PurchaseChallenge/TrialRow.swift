//
//  TrialRow.swift
//  PurchaseChallenge
//
//  Created by Silvia Kuzmova on 23.11.21.
//

import SwiftUI

struct TrialRow: View {

    // MARK: - Constants

    enum Constants {

        enum Title {
            static let font = Font.system(size: 18).weight(.bold)
        }

        enum Subtitle {
            static let font = Font.system(size: 14)

        }
    }


    let rowData: RowData
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [rowData.topColor, rowData.bottomColor]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .frame(width: 32)
                    .frame(maxHeight: 100)
                    .if(rowData.roundTopCorners, transform: { view in
                        view.cornerRadius(20, corners: [.topLeft, .topRight])
                    })

                if rowData.iconName != nil {
                    Icon(iconName: rowData.iconName!)
                }
            }

            VStack(alignment: .leading, spacing: 8.0) {
                Text(rowData.title)
                    .font(Constants.Title.font)
                Text(rowData.subTitle)
                    .font(Constants.Subtitle.font)
            }

        }
    }
}

struct Icon: View {

    enum Constants {
        static let topColor = Color("ocean-green")
        static let bottomColor = Color("ocean-blue")
    }

    var iconName: String

    var body: some View {
        Image(systemName: iconName)
            .renderingMode(.template)
            .foregroundColor(.black)
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .background(
                LinearGradient(gradient: Gradient(colors: [Constants.topColor, Constants.bottomColor]),
                               startPoint: .center,
                               endPoint: .bottom)
            )
            .clipShape(Circle())
            .padding(.top, 4)
    }
}

struct TrialRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        TrialRow(rowData: .fiveDays)
            .previewLayout(.sizeThatFits)

        TrialRow(rowData: .now)
            .previewLayout(.sizeThatFits)
        }
    }
}

//
//  TrialView.swift
//  PurchaseChallenge
//
//  Created by Silvia Kuzmova on 23.11.21.
//

import SwiftUI
import UIKit

enum Constants {

    static let backgroundColor = Color("main-background")
    static let navigationFontColor = UIColor(hexString: "#6D6D72")
    static let cornerRadius: CGFloat = 11
    static let roundedRectangleBackgroundColor = Color("box-color")

    enum Button {
        static let topColor = Color("ocean-green")
        static let bottomColor = Color("ocean-blue")

        static let topColor2 = Color("ocean-green-transparent")
        static let bottomColor2 = Color("ocean-blue-transparent")

        static let fontColor = Color("green-dark")
    }
}

struct ContentView: View {

    @ObservedObject var viewModel = TrialViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Constants.backgroundColor
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 0)
                {
                    ForEach(RowData.allCases) { rowData in
                        TrialRow(rowData: rowData)
                    }
                    .listRowSeparator(.hidden)
                    .padding(.horizontal)
                    .if(UIDevice.current.userInterfaceIdiom == .pad, transform: { view in
                        // TODO: align to the middle
                        view.padding(.horizontal, 100)
                    })

                        Spacer(minLength:  UIDevice.current.userInterfaceIdiom == .pad ? 200 : 50)

                    BottomView(monthlyPrice: String(viewModel.monthlyPrice),
                               yearlyPrice: String(viewModel.yearlyPrice))
                }
                .padding(.top, 20)
                .navigationTitle("Thanks for trying Mate!")
                .navigationBarTitleDisplayMode(.inline)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = .blue
                    nc.navigationBar.titleTextAttributes = [.foregroundColor : Constants.navigationFontColor]
                })
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(0.0)

    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }

        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro"))
        }
    }
}




struct BottomView: View {

    let monthlyPrice: String
    let yearlyPrice: String

    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Constants.Button.topColor, Constants.Button.bottomColor]),
                                            startPoint: UnitPoint(x: 0.5, y: 0.75),
                                            endPoint: UnitPoint(x: 0.5, y: 1.0))

    let backgroundGradientTransparent = LinearGradient(gradient: Gradient(colors: [Constants.Button.topColor2, Constants.Button.bottomColor2]),
                                                       startPoint: .center,
                                                       endPoint: .top)

    var body: some View {
        ZStack {
            Rectangle ()
                .fill(Color("main-white"))
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.04), radius: 16)

            VStack(alignment: .center, spacing: 16.0) {
                ZStack {

                    VStack(alignment: .center, spacing: 12) {
                        Text("$\(monthlyPrice)")
                            .font(Font.system(size: 25).weight(.bold)) +
                        Text(" /month after trial")
                            .font(Font.system(size: 14))

                        Text("That’s $\(yearlyPrice) /year.")
                            .font(Font.system(size: 16))
                    }
                    .frame(height: 102)
                    .frame(maxWidth: .infinity)
                    .background(Constants.roundedRectangleBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                    )
                }

                Text("Change your mind? Cancel any time.")
                    .font(Font.system(size: 14))

                Button("Start trial".uppercased()) {
                    print("start trial")
                }
                .padding()
                .font(Font.system(size: 16).weight(.bold))
                .frame(maxWidth: .infinity)
                .foregroundColor(Constants.Button.fontColor)
                .background(
                    ZStack {
                        backgroundGradient
                        backgroundGradientTransparent
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))

            }
            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 100 : 12)

        }
    }
}

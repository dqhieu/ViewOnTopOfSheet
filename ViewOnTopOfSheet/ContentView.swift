//
//  ContentView.swift
//  ViewOnTopOfSheet
//
//  Created by Dinh Quang Hieu on 18/02/2022.
//

import SwiftUI
import UIKit

var overlayWindow: UIWindow?

struct ContentView: View {
  
  @State var isPresenting = false
  
  var body: some View {
    ZStack {
      Button {
        isPresenting.toggle()
      } label: {
        Text("Button")
      }
      .sheet(isPresented: $isPresenting) {
        Text("Hello world")
      }
    }
    .onAppear {
      showOverlayView()
    }
  }
  
  func showOverlayView() {
    if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      overlayWindow = UIHigherWindow(windowScene: currentWindowScene)
    }
    overlayWindow?.windowLevel = UIWindow.Level.alert + 1
    let hostVC = UIHostingController(rootView: OverlayView())
    hostVC.view.backgroundColor = .clear
    overlayWindow?.rootViewController = hostVC
    overlayWindow?.backgroundColor = UIColor.clear
    overlayWindow?.makeKeyAndVisible()
  }
}

struct OverlayView: View {
  var body: some View {
    VStack {
      Spacer()
      RoundedRectangle(cornerRadius: 20)
        .fill(.red)
        .frame(width: 100, height: 100)
    }
  }
}

class UIHigherWindow: UIWindow {
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    
    let hitView = super.hitTest(point, with: event)
    
    if hitView!.isKind(of: UIView.self) {
      
      return nil
    }
    
    return hitView
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

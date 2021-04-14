//
//  ContentView.swift
//  Shared
//
//  Created by Dustin Olsen on 4/8/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric auth is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead
            let reason = "Unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication complete
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
        
        
    }
//    func getDocumentsDirectory() -> URL {
//        // find all possible documents directories for this user
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        // just send back the first one, which should be the only one
//        return paths[0]
//    }
    
    
    
    
    var body: some View {
        
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
        
//        MapView()
//            .edgesIgnoringSafeArea(.all)
            
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

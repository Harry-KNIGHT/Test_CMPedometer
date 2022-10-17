//
//  ContentView.swift
//  CMPedometerTest
//
//  Created by Elliot Knight on 17/10/2022.
//

import SwiftUI
import CoreMotion

struct ContentView: View {

	private let pedometer: CMPedometer = CMPedometer()
	//private let activityManager = CMMotionActivityManager()


	private var isPedometerAvailable: Bool {
		return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isCadenceAvailable()
	}

	
	func updateUI(data: CMPedometerData) {
		steps = data.numberOfSteps.intValue
		guard let pedometerDistance = data.distance else { return }
		distance = pedometerDistance.doubleValue

	}
	private func initializePodometer() {
		if isPedometerAvailable {
			pedometer.startUpdates(from: Date()) { (data, error) in
				guard let data = data, error == nil else { return }
				updateUI(data: data)
			}
		}
	}

	@State private var steps: Int?
	@State private var distance: Double?

	var body: some View {
		VStack {
			if let steps {
				Text("\(steps.description) steps")
			} else {
				Text("0 steps !")
			}
			if let distance {
				Text("\(String(format: "%.2f meters", distance))")
			} else {
				Text("0 meter!")
			}
		}
		.onAppear {
			initializePodometer()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

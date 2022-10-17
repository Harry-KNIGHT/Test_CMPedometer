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
			guard let startDate = Calendar.current.date(byAdding: .minute, value: -60, to: Date()) else { return }
			
			pedometer.queryPedometerData(from: startDate, to: Date()) {  (data, error) in
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
				Text(steps.description)
			}
			if let distance {
				Text("\(String(format: "%.2f meters", distance))")
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

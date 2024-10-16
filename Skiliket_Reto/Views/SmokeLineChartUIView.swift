//
//  SmokeLineChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import SwiftUI
import Charts

struct SmokeLineChartUIView: View {
    @ObservedObject var smokeData: SmokeData

    var body: some View {
        VStack {
            // Single white header
            Text("Smoke Levels (%)")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            // Chart view with black background, red area, and white axis
            Chart {
                ForEach(smokeData.smokes, id: \.timeStamp) { smoke in
                    // Define the AreaMark for the area chart
                    AreaMark(
                        x: .value("Time", smoke.timeStamp, unit: .second),
                        y: .value("Smoke", Double(smoke.value) ?? 0)
                    )
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )) // Red gradient for the area
                }
            }
            .chartYScale(domain: 0...100)  // Smoke levels typically range from 0 to 100%
            .chartXAxis {
                AxisMarks(values: .automatic) {
                    AxisGridLine().foregroundStyle(Color.white) // White grid lines for x-axis
                    AxisTick().foregroundStyle(Color.white) // White tick marks for x-axis
                    AxisValueLabel(format: .dateTime.second())
                        .foregroundStyle(Color.white) // White x-axis labels
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) {
                    AxisGridLine().foregroundStyle(Color.white) // White grid lines for y-axis
                    AxisTick().foregroundStyle(Color.white) // White tick marks for y-axis
                    AxisValueLabel()
                        .foregroundStyle(Color.white) // White y-axis labels
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .padding([.leading, .trailing], 16) // Add padding to prevent cutting off the chart
            .background(Color.black) // Black background for the chart area

            // X-Axis title
            Text("Time (Seconds)")
                .font(.caption) // Smaller font size for axis title
                .foregroundColor(.white)
                .padding(.top, 8) // Add some space between the chart and the title
        }
        .background(Color.black) // Black background for the entire view
    }
}



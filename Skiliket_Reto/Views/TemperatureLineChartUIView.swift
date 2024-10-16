//
//  TemperatureLineChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 14/10/24.
//

import SwiftUI
import Charts

struct TemperatureLineChartUIView: View {
    @ObservedObject var temperatureData: TemperatureData

    var body: some View {
        VStack {
            // Single white header
            Text("Temperature in Monterrey (°F)")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            // Chart view with black background, green line, and white axis
            Chart {
                ForEach(temperatureData.temperatures, id: \.timeStamp) { temp in
                    LineMark(
                        x: .value("Time", temp.timeStamp, unit: .second),
                        y: .value("Temperature", Double(temp.value) ?? 0)
                    )
                    .foregroundStyle(Color.green) // Line in green
                }
            }
            .chartYScale(domain: 60...110)
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine().foregroundStyle(Color.white) // White grid lines for x-axis
                    AxisTick().foregroundStyle(Color.white) // White tick marks for x-axis
                    AxisValueLabel(format: .dateTime.second())
                        .foregroundStyle(Color.white) // White x-axis labels
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
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







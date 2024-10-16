import SwiftUI
import Charts

struct HumidityLineChartUIView: View {
    @ObservedObject var humidityData: HumidityData

    var body: some View {
        VStack {
            // Single white header
            Text("Humidity Levels (%)")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            // Chart view with black background, blue area, and white axis
            Chart {
                ForEach(humidityData.humidities, id: \.timeStamp) { humidity in
                    // Define the AreaMark for the area chart
                    AreaMark(
                        x: .value("Time", humidity.timeStamp, unit: .second),
                        y: .value("Humidity", Double(humidity.value) ?? 0)
                    )
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )) // Blue gradient for the area
                }
            }
            .chartYScale(domain: 0...100)  // Humidity typically ranges from 0 to 100%
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





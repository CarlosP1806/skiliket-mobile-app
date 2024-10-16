import SwiftUI
import Charts

struct HumidityLineChartUIView: View {
    @ObservedObject var humidityData: HumidityData
    
    var body: some View {
        VStack {
            Text("Humidity")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            // Gráfico con fondo negro
            Chart {
                ForEach(humidityData.humidity_, id: \.timeStamp) { temp in
                    LineMark(
                        x: .value("Time", temp.timeStamp, unit: .second),
                        y: .value("Temperature", Double(temp.value) ?? 0)
                    )
                    .foregroundStyle(.green)
                }
            }
            
            .chartYScale(domain: 100...400)
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine().foregroundStyle(Color.white)
                    AxisTick().foregroundStyle(Color.white)
                    AxisValueLabel(format: .dateTime.second())
                        .foregroundStyle(Color.white)
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine().foregroundStyle(Color.white)
                    AxisTick().foregroundStyle(Color.white)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartXAxisLabel("Date & Time", position: .bottom) // Etiqueta del eje X
                            .foregroundStyle(Color.white) // Color de la etiqueta
                        .chartYAxisLabel("°Humidity g/m³", position: .leading) // Etiqueta del eje Y
                            .foregroundStyle(Color.white) // Color de la etiqueta

            .frame(maxWidth: .infinity, maxHeight: 400)
            .padding([.leading, .trailing], 16)// Remove extra padding
            .background(Color.black) // Ensure chart background extends


            Text("Time (Seconds)")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.top, 8)

                 
        }
        
        .background(Color.black)  // Fondo negro para todo el VStack
    }
}


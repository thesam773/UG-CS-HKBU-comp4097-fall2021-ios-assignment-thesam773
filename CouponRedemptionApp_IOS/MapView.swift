//
//  MapView.swift
//  InfoDayJuly2021 (iOS)
//
//  Created by f0220952 on 30/9/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @FetchRequest(entity: CouponMall.entity(), sortDescriptors: [])
    
    var couponMall: FetchedResults<CouponMall>
    var coupon_mall = ""
    
    init(coupon_mall: String){
        self.coupon_mall = coupon_mall
        
        self._couponMall = FetchRequest(
            entity: CouponMall.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "mall == %@", coupon_mall)
        )
    }
    
    

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 22.33787,
            longitude: 114.18131
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
        )
    )
    
    var body: some View {
        ZStack(alignment:.bottom){
            Map(coordinateRegion: $region, annotationItems: Building.campusBuildings) { building in
//                MapMarker(coordinate: building.coordinate)
                MapAnnotation(coordinate: building.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .foregroundColor(Color(.systemRed))
                    Text(building.title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 150)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            Button("Reset") {
                withAnimation {
                    region.center = CLLocationCoordinate2D(
                        latitude: Double(couponMall[0].latitude!) ?? 123,
                        longitude: Double(couponMall[0].longitude!) ?? 123
                    )
                }
            }
            .padding()
        }
        .onAppear(perform: getLocation)
    }
}

extension MapView{
    func getLocation(){
        if(couponMall.count > 0 ){
            Building.setBuilding(mall: couponMall)
            print(couponMall[0].latitude!)
            print(couponMall[0].longitude!)
            region.center = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(Double(couponMall[0].latitude!) ?? 123),
                longitude: CLLocationDegrees(Double(couponMall[0].longitude!) ?? 123)
            )
        }
        Building.setBuilding(mall: couponMall)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coupon_mall:"mall")
    }
}

struct Building: Identifiable {
    
    var id = UUID()
    let title: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Building {
    static var campusBuildings: [Building] = []
    
    static func setBuilding(mall:FetchedResults<CouponMall>){
        mall.forEach{ ml in
            print("Mother Fucker\(Double(ml.latitude!) ?? 123)")
            self.campusBuildings.append(
                Building(title: ml.mall!, latitude: Double(ml.latitude!) ?? 123, longitude: Double(ml.longitude!) ?? 123))
        }
    }
}

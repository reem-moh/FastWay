//
//  EntireMapView.swift
//  maptest3
//
//  Created by Shahad AlOtaibi on 02/07/1442 AH.
//

import SwiftUI
import MapKit
import UIKit


/*struct EntireMapView_Previews: PreviewProvider {
    static var previews: some View {
        EntireMapView()
    }
}*/

struct EntireMapView: UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!


        func updateUIView(_ mapView: MKMapView, context: Context) {

            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            var riyadhCoordinate = CLLocationCoordinate2D()
            riyadhCoordinate.latitude = 24.72640308847297
            riyadhCoordinate.longitude = 46.638332536327816
            let region = MKCoordinateRegion(center: riyadhCoordinate, span: span)
            mapView.setRegion(region, animated: true)

        }

        func makeUIView(context: Context) -> MKMapView {

           // let myMap = MKMapView(frame: .zero)
            map = MKMapView(frame: .zero)
            map.delegate = context.coordinator
            manager.delegate = context.coordinator as? CLLocationManagerDelegate
            map.showsUserLocation = true
            let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(EntireMapViewCoordinator.addAnnotation(gesture:)))
            longPress.minimumPressDuration = 1
            map.addGestureRecognizer(longPress)
            map.delegate = context.coordinator
            return map
        }
    

    func makeCoordinator() -> EntireMapViewCoordinator {
        return EntireMapViewCoordinator(self)
    }

    class EntireMapViewCoordinator: NSObject, MKMapViewDelegate {

        var entireMapViewController: EntireMapView

        init(_ control: EntireMapView) {
          self.entireMapViewController = control
        }


        @objc func addAnnotation(gesture: UIGestureRecognizer) {

            if gesture.state == .ended {

                if let mapView = gesture.view as? MKMapView {
                let point = gesture.location(in: mapView)
                let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                mapView.addAnnotation(annotation)
                }
            }
        }
    }
}
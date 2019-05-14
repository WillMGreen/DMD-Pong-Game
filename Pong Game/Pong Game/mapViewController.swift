import UIKit
import MapKit
import Firebase

class mapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        mapView.register(CustomAnnotation.self, forAnnotationViewWithReuseIdentifier: "annotation")
            mapView.delegate = self
        
        //      let firstCoordinate = CLLocationCoordinate2D (latitude: 50.742230, longitude: -1.896199)
        //        let firstAnnotation = CustomAnnotation (coordinate: firstCoordinate, title: "Bournemouth University, Talbot campus")
        //        mapView.addAnnotation(firstAnnotation)
        //
        //        let secondCoordinate = CLLocationCoordinate2D (latitude: 50.723069, longitude: -1.864987)
        //        let secondAnnotation = CustomAnnotation (coordinate: secondCoordinate, title: "Bournemouth Old fire Station")
        //        mapView.addAnnotation(secondAnnotation)
        //
        //        let thirdCoordinate = CLLocationCoordinate2D (latitude: 50.714295, longitude: -1.874776)
        //        let thirdAnnotation = CustomAnnotation (coordinate: thirdCoordinate, title: "Bournemouth Pier")
        //        mapView.addAnnotation(thirdAnnotation)
        
         loadLocations()
    }
    
    func loadLocations() {
        let ref = Firestore.firestore().collection("locations")
        ref.getDocuments { (snapshot, error) in
            for document in snapshot!.documents {
            let annotation = CustomAnnotation(document: document)
                self.mapView.addAnnotation(annotation)
    }
}
   }

}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
let vc = segue.destination as!GameViewController
let annotation = sender as? CustomAnnotation
vc.annotation = annotation
        
    }
    
extension mapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CustomAnnotation else
        { return }
        performSegue(withIdentifier: "Next", sender: annotation)
        mapView.deselectAnnotation(annotation, animated: true)
    }

}

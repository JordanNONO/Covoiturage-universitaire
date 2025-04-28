class AppServer{
  static const API = "http://localhost:8009";
  static const UTILISATEUR = API + "/utilisateur";
  static const AVIS = API + "/avis";
  static const PAIEMENT = API + "/paiement";
  static const RESERVATION = API + "/reservation";
  static const ROLE = API + "/role";
  static const TRAJET = API + "/trajet";
  static const VEHICULE = API + "/vehicule";
  static const MESSAGERIE = API + "/messagerie";
  static const LOGIN = API + "/auth/login";

  static const headers ={
    'Content-Type' : 'application/json',
    "Access-Control-Allow-Origin": "*",
    'Accept':'application/json'
  };
}
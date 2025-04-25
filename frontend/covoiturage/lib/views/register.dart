import 'package:covoiturage/models/Utilisateur.dart';
import 'package:covoiturage/services/Utilisateur_Service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<RegisterScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController photoProfilController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Utilisateur> utilisateurs = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    utilisateurs = await UtilisateurService().getAll();
    setState(() {});
  }

  Future<void> save([Utilisateur? utilisateur]) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (utilisateur != null) {
          await UtilisateurService().update(utilisateur.utilisateurId!, utilisateur);
        } else {
          await UtilisateurService().save(Utilisateur(
            nom: nomController.text,
            prenom: prenomController.text,
            email: emailController.text,
            motDePasse: motDePasseController.text,
            telephone: telephoneController.text,
            photoProfil: photoProfilController.text,
            dateInscription: DateTime.now(),
            noteMoyenne: 0.0,
          ));
        }
        fetchUsers();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Utilisateur enregistré avec succès")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> deleteUser(Utilisateur utilisateur) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmer la suppression"),
        content: Text("Êtes-vous sûr de vouloir supprimer cet utilisateur ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () async {
              await UtilisateurService().delete(utilisateur.utilisateurId!);
              fetchUsers();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Utilisateur supprimé avec succès")),
              );
            },
            child: Text("Supprimer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gestion des Utilisateurs")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: utilisateurs.length,
                itemBuilder: (context, index) {
                  final user = utilisateurs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: user.photoProfil != null
                            ? NetworkImage(user.photoProfil!)
                            : null,
                        child: user.photoProfil == null
                            ? Icon(Icons.person)
                            : null,
                      ),
                      title: Text("${user.nom} ${user.prenom}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.email ?? ''),
                          Text(user.telephone ?? ''),
                          Text("Note: ${user.noteMoyenne?.toStringAsFixed(1) ?? '0.0'}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              nomController.text = user.nom ?? '';
                              prenomController.text = user.prenom ?? '';
                              emailController.text = user.email ?? '';
                              motDePasseController.text = user.motDePasse ?? '';
                              telephoneController.text = user.telephone ?? '';
                              photoProfilController.text = user.photoProfil ?? '';
                              showDialog(
                                context: context,
                                builder: (context) => buildUserForm(context, user),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteUser(user),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nomController.clear();
                prenomController.clear();
                emailController.clear();
                motDePasseController.clear();
                telephoneController.clear();
                photoProfilController.clear();
                showDialog(
                  context: context,
                  builder: (context) => buildUserForm(context),
                );
              },
              child: Text("Ajouter Utilisateur"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserForm(BuildContext context, [Utilisateur? utilisateur]) {
    return AlertDialog(
      title: Text(utilisateur == null ? "Ajouter Utilisateur" : "Modifier Utilisateur"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(labelText: "Nom"),
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              TextFormField(
                controller: prenomController,
                decoration: InputDecoration(labelText: "Prénom"),
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              TextFormField(
                controller: motDePasseController,
                decoration: InputDecoration(labelText: "Mot de passe"),
                obscureText: true,
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              TextFormField(
                controller: telephoneController,
                decoration: InputDecoration(labelText: "Téléphone"),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: photoProfilController,
                decoration: InputDecoration(labelText: "URL Photo de profil"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            save(utilisateur);
            Navigator.of(context).pop();
          },
          child: Text("Enregistrer"),
        ),
      ],
    );
  }
}
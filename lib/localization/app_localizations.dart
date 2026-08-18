class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      'title': 'Chantons Le Seigneur',
      'search': 'Rechercher un chant (titre, numéro)...',
      'settings': 'Paramètres',
      'high_contrast': 'Mode contraste élevé',
      'text_size': 'Taille du texte',
      'language': 'Langue',
      'all_songs': 'Tous',
      'french': 'Français',
      'creole': 'Créole',
      'no_results': 'Aucun chant trouvé',
      'add_song': 'Ajouter un chant',
      'edit_song': 'Modifier le chant',
      'delete_song': 'Supprimer le chant',
      'delete_confirm': 'Confirmer la suppression',
      'delete_confirm_desc': 'Êtes-vous sûr de vouloir supprimer ce chant ?',
      'save': 'Enregistrer',
      'cancel': 'Annuler',
      'delete': 'Supprimer',
      'song_number': 'Numéro du chant',
      'song_title': 'Titre du chant',
      'song_lyrics': 'Paroles',
      'song_language': 'Langue du chant',
      'field_required': 'Ce champ est obligatoire',
      'number_required': 'Veuillez saisir un numéro',
      'title_required': 'Veuillez saisir un titre',
      'lyrics_required': 'Veuillez saisir les paroles',
    },
    'ht': {
      'title': 'Chantons Le Seigneur',
      'search': 'Chèche yon chante (tit nan, nimewo)...',
      'settings': 'Anviwònman',
      'high_contrast': 'Gwo kontras',
      'text_size': 'Kantite tèks',
      'language': 'Lang',
      'all_songs': 'Tout',
      'french': 'Franse',
      'creole': 'Kreyòl Ayisyen',
      'no_results': 'Nou pa jwenn okenn chante',
      'add_song': 'Ajoute yon chante',
      'edit_song': 'Chanje chante a',
      'delete_song': 'Efase chante a',
      'delete_confirm': 'Konfime efase a',
      'delete_confirm_desc': 'Èske ou sèten ou vle efase chante sa a?',
      'save': 'Anrejistre',
      'cancel': 'Anile',
      'delete': 'Efase',
      'song_number': 'Nimewo chante a',
      'song_title': 'Tit chante a',
      'song_lyrics': 'Pawòl',
      'song_language': 'Lang chante a',
      'field_required': 'Jaden sa a obligatwa',
      'number_required': 'Tanpri antre yon nimewo',
      'title_required': 'Tanpri antre yon tit',
      'lyrics_required': 'Tanpri antre pawòl yo',
    },
  };

  String get(String key) {
    return _localizedValues[locale]?[key] ?? key;
  }
}

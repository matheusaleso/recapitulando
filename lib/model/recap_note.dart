class RecapNote {
  int _dataLocation;

  String _name;
  String _username;
  String _email;
  String _favoriteSerie;
  String _password;
  int _action;
  int _adventure;
  int _comedy;
  int _drama;
  int _fantasy;
  int _horror;
  int _musical;

  String _seriePoster;
  String _serieName;
  String _serieSinopse;
  String _serieGenre;
  double _serieGeneralrate;
  double _serieMyrate;
  int _numberSeasons;
  int _numberEpisodes;
  int _idSerie;

  int _season;
  int _episodes;

  int _rate;
  int _idReview;
  String _comment;

  RecapNote() {
    /*
      0 = undefined
      1 = local
      2 = internet
    */

    _dataLocation = 1;
    _name = "";
    _username = "";
    _email = "";
    _favoriteSerie = "";
    _password = "";
    _action = 0;
    _adventure = 0;
    _comedy = 0;
    _drama = 0;
    _fantasy = 0;
    _horror = 0;
    _musical = 0;

    /*Série*/
    /* _seriePoster = "";
    _serieName = "";
    _serieSinopse = "";
    _serieGenre = "";
    _serieGeneralrate = 0;
    _serieMyrate = 0;
    _numberSeasons = 1;
    _numberEpisodes = 1; */

    _episodes = 0;
    _rate = 0;
    _comment = "";
    idSerie = 1;
    _idReview = 0;
  }

  RecapNote.fromMap(map) {
    this._name = map["name"];
    this._username = map["username"];
    this._email = map["email"];
    this._favoriteSerie = map["favoriteSerie"];
    this._password = map["password"];
    this._action = map["GenreAction"];
    this._adventure = map["GenreAdventure"];
    this._comedy = map["GenreComedy"];
    this._drama = map["GenreDrama"];
    this._fantasy = map["GenreFantasy"];
    this._horror = map["GenreHorror"];
    this._musical = map["GenreMusical"];

    /*Série*/
    this._seriePoster = map["seriePoster"];
    this._serieName = map["serieName"];
    this._serieSinopse = map["serieSinopse"];
    this._serieGenre = map["serieGenre"];
    this._serieGeneralrate = map["serieGeneralrate"];
    this._serieMyrate = map["serieMyrate"];
    this._numberSeasons = map["numberSeasons"];
    this._numberEpisodes = map["numberEpisodes"];
    this._idSerie = map["idSerie"];

    /*Informações de temporadas*/
    this._season = map["season"];
    this._episodes = map["episodes"];

    /*Avaliações*/
    this._rate = map["rate"];
    this._comment = map["comment"];
    this._idReview = map["idReview"];
  }

  /*RecapNote.fromMapSerie(map) {
    /*Série*/
    this._seriePoster = map["seriePoster"];
    this._serieName = map["serieName"];
    this._serieSinopse = map["serieSinopse"];
    this._serieGenre = map["serieGenre"];
    this._serieGeneralrate = map["serieGeneralrate"];
    this._serieMyrate = map["serieMyrate"];
    this._numberSeasons = map["numberSeasons"];
    this._numberEpisodes = map["numberEpisodes"];
  } */

  String get name => _name;
  String get username => _username;
  String get email => _email;
  String get favoriteSerie => _favoriteSerie;
  String get password => _password;
  int get action => _action;
  int get adventure => _adventure;
  int get comedy => _comedy;
  int get drama => _drama;
  int get fantasy => _fantasy;
  int get horror => _horror;
  int get musical => _musical;
  int get dataLocation => _dataLocation;

  /* Série */
  String get seriePoster => _seriePoster;
  String get serieName => _serieName;
  String get serieSinopse => _serieSinopse;
  String get serieGenre => _serieGenre;
  double get serieGeneralrate => _serieGeneralrate;
  double get serieMyrate => _serieMyrate;
  int get numberSeasons => _numberSeasons;
  int get numberEpisodes => _numberEpisodes;
  int get idSerie => _idSerie;

  /*Temporadas*/
  int get season => _season;
  int get episodes => _episodes;

  /*Avaliações*/
  int get rate => _rate;
  int get idReview => _idReview;
  String get comment => _comment;

  set name(String newName) {
    if (newName.length > 0) {
      this._name = newName;
    }
  }

  set username(String newUsername) {
    if (newUsername.length > 0) {
      this._username = newUsername;
    }
  }

  set email(String newEmail) {
    if (newEmail.length > 0) {
      this._email = newEmail;
    }
  }

  set favoriteSerie(String newFavoriteSerie) {
    if (newFavoriteSerie.length > 0) {
      this._favoriteSerie = newFavoriteSerie;
    }
  }

  set password(String newPassword) {
    if (newPassword.length > 0) {
      this._password = newPassword;
    }
  }

  set action(int newAction) {
    if ((newAction == 0) || (newAction == 1)) {
      this._action = newAction;
    }
  }

  set adventure(int newAdventure) {
    if ((newAdventure == 0) || (newAdventure == 1)) {
      this._adventure = newAdventure;
    }
  }

  set comedy(int newComedy) {
    if ((newComedy == 0) || (newComedy == 1)) {
      this._comedy = newComedy;
    }
  }

  set drama(int newDrama) {
    if ((newDrama == 0) || (newDrama == 1)) {
      this._drama = newDrama;
    }
  }

  set fantasy(int newFantasy) {
    if ((newFantasy == 0) || (newFantasy == 1)) {
      this._fantasy = newFantasy;
    }
  }

  set horror(int newHorror) {
    if ((newHorror == 0) || (newHorror == 1)) {
      this._horror = newHorror;
    }
  }

  set musical(int newMusical) {
    if ((newMusical == 0) || (newMusical == 1)) {
      this._musical = newMusical;
    }
  }

  set dataLocation(int newLocation) {
    if (newLocation > 0 && newLocation < 3) {
      this._dataLocation = newLocation;
    }
  }

  /*Serie*/
  set seriePoster(String newSeriePoster) {
    if (newSeriePoster.length > 0) {
      this._seriePoster = newSeriePoster;
    }
  }

  set serieName(String newSerieName) {
    if (newSerieName.length > 0) {
      this._serieName = newSerieName;
    }
  }

  set serieSinopse(String newSerieSinopse) {
    if (newSerieSinopse.length > 0) {
      this._serieSinopse = newSerieSinopse;
    }
  }

  set serieGenre(String newSerieGenre) {
    if (newSerieGenre.length > 0) {
      this._serieGenre = newSerieGenre;
    }
  }

  set serieGeneralrate(double newSerieGeneralrate) {
    if (newSerieGeneralrate >= 0) {
      this._serieGeneralrate = newSerieGeneralrate;
    }
  }

  set serieMyrate(double newSerieMyrate) {
    if (newSerieMyrate >= 0) {
      this._serieMyrate = newSerieMyrate;
    }
  }

  set rate(int newRate) {
    this._rate = newRate;
  }

  set comment(String newComment) {
    this._comment = newComment;
  }

  set season(int newTemporada) {
    this._season = newTemporada;
  }

  set episodes(int newEpisodios) {
    this._episodes = newEpisodios;
  }

  set idSerie(int newIdSerie) {
    this._idSerie = newIdSerie;
  }

  set idReview(int newReview) {
    this.idReview = newReview;
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["email"] = _email;
    map["favoriteSerie"] = _favoriteSerie;
    map["password"] = _password;
    map["GenreAction"] = _action;
    map["GenreAdventure"] = _adventure;
    map["GenreComedy"] = _comedy;
    map["GenreDrama"] = _drama;
    map["GenreFantasy"] = _fantasy;
    map["GenreHorror"] = _horror;
    map["GenreMusical"] = _musical;

    /*Série*/
    /* map["seriePoster"] = _seriePoster;
    map["serieName"] = _serieName;
    map["serieSinopse"] = _serieSinopse;
    map["serieGenre"] = _serieGenre;
    map["serieGeneralrate"] = _serieGeneralrate;
    map["serieMyrate"] = _serieMyrate;
    map["numberSeasons"] = _numberSeasons;
    map["numberEpisodes"] = _numberEpisodes;*/

    /*Review*/
    this._rate = map["rate"];
    this._comment = map["comment"];
    this._season = map["season"];
    this._episodes = map["episodes"];
    this._idSerie = map["idSerie"];
    this._idReview = map["idReview"];
    return map;
  }

  /*toMapSerie() {
    var map = Map<String, dynamic>();

    /*Série*/
    map["seriePoster"] = _seriePoster;
    map["serieName"] = _serieName;
    map["serieSinopse"] = _serieSinopse;
    map["serieGenre"] = _serieGenre;
    map["serieGeneralrate"] = _serieGeneralrate;
    map["serieMyrate"] = _serieMyrate;
    map["numberSeasons"] = _numberSeasons;
    map["numberEpisodes"] = _numberEpisodes;

    return map;
  }*/
}

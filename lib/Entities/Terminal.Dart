class Terminal {
  // Приватный статический экземпляр
  static final Terminal _instance = Terminal._internal();

  // Поле для хранения ID
  late int id;

  // Приватный конструктор
  Terminal._internal();

  // Фабричный конструктор для получения экземпляра
  factory Terminal() {
    return _instance;
  }

  // Метод для установки ID
  void setId(int newId) {
    id = newId;
  }

  // Метод для получения ID
  int getId() {
    return id;
  }
}

class DarkModeEvent {
  final bool isDarkMode;
  DarkModeEvent(this.isDarkMode);
}

class VolumenChangedEvent {
  final double volume;
  VolumenChangedEvent(this.volume);
}

class ChangeScreenEvent {
  final int screenIndex;
  ChangeScreenEvent(this.screenIndex);
}
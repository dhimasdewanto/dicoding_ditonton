enum ShowType {
  movie,
  tv,
}

ShowType getTypeFromName(String name) {
  switch (name) {
    case 'movie':
      return ShowType.movie;
    case 'tv':
      return ShowType.tv;
    default:
      return ShowType.tv;
  }
}

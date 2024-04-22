enum CommunityTab {
  INTERACTION,
  BLOG,
}

extension InfoCommunityTab on CommunityTab {
  String getName() {
    switch (this) {
      case CommunityTab.INTERACTION:
        return "Tương tác";
      case CommunityTab.BLOG:
        return "Blog";
      default:
        return "";
    }
  }
}

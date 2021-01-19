class ListUtil {
  static bool isEmpty(List list) {
    return list == null || list.isEmpty;
  }

  static int size(List list) {
    if (isEmpty(list)) {
      return 0;
    }
    return list.length;
  }
}

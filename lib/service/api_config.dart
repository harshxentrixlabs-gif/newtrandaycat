class ApiConfig {
  static const String baseUrl = "https://trendybackend.codestoreapp.com";
  static const SECRET_KEY = " 1234567890";

  static const String endUrl = "/api/v1";
  static const String apiUrl = baseUrl + endUrl;

  // AUTH
  static const String login = "$apiUrl/auth/login";


  static const BASE_URL = "https://trendybackend.codestoreapp.com/";

  static const userLogin = "$baseUrl/user/login";
  static const liveSeller = "$baseUrl/liveSeller/liveSellerList";
  static const reelUser = "$baseUrl/reel/getReelsForUser";
  static const justForYouProducts = "$baseUrl/product/justForYouProducts";
  static const newCollection = "$baseUrl/product/geAllNewCollection";
  static const myOrder = "$baseUrl/order/orderDetailsForUser";
  static const favorite = "$baseUrl/favorite/favoriteProduct";



  static String getDomainFromURL(String url) {
    print("FIRST URL --> $url");
    final uri = Uri.parse(url);

    String host = uri.host;
    int port;

    if (uri.hasPort) {
      port = uri.port;
    } else {
      port = uri.scheme == "https" ? 443 : 80;
    }

    if (host.startsWith("www.")) {
      host = host.substring(4);
    }

    String hostWithPort = "$host:$port";
    print("object::::::host uri:::$hostWithPort");

    return hostWithPort;
  }


}




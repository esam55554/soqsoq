class ApiRoutes {
  static const _BASE_URL = "https://soqsoq.dev-options.com/api";

  // Auth Routes
  static const LOGIN = "$_BASE_URL/auth/login";
  static const REGISTER = "$_BASE_URL/auth/register";
  static const LOGOUT = "$_BASE_URL/auth/logout";
  static const FORGOT_PASSWORD = "$_BASE_URL/auth/forgot-password";
  static const RESET_PASSWORD = "$_BASE_URL/auth/reset-password";
  static const CHANGE_PASSWORD = "$_BASE_URL/auth/change-password";
  static const USER_PROFILE = "$_BASE_URL/user/profile";
  static const UPDATE_PROFILE = "$_BASE_URL/user/profile/update";

  // Product Routes
  static const PRODUCTS = "$_BASE_URL/products";
  static String productDetail(int id) => "$_BASE_URL/products/$id";

  // Order Routes
  static const ORDERS = "$_BASE_URL/orders";
  static String orderDetail(int id) => "$_BASE_URL/orders/$id";

  // Category Routes
  static const CATEGORIES = "$_BASE_URL/categories";

  // Upload Routes
  static const UPLOAD = "$_BASE_URL/upload";
}
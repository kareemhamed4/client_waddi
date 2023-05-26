// ignore_for_file: constant_identifier_names

const BASEURL = "http://192.168.1.12:8080/";

//user endPoints
const LOGIN = "auth/login";
const USERREGISTER = "auth/register?type=personal";
const COMPANYREGISTER = "auth/register?type=comapny";
const FORGETPASSWORD = "auth/forget";
const VERIFYOTP = "auth/verifyotp";
const UPDATEPASSWORD = "auth/updatepassword";
const UPDATEPASSWORDAUTHUSER = "auth/changepassword";
const GETUSERINFO = "auth/userInfo";
const MAKEORDER = "client/order";
const GETUSERORDERS = "client/orders";
const USERSEARCHORDERID ="client/order/";
const USERSEARCHTRACKID ="client/order/track/";
const UPDATEORDER = "client/order/";
const DELETEORDER = "client/order/";
const GETRATE = "client/get_rate";

//delegate endPoints
const DELEGATEGETALLORDERS = "delegate/orders";
const DELEGATEGETORDERBYID = "delegate/orders/";
const DELEGATETAKEORDERBYID = 'delegate/take_order/';
const DELEGATEGETHISORDERS = 'delegate/delegate_orders';
const DELEGATECONFIRMORDER = 'delegate/confirm_order/';
const DELEGATESENDORDERPROOF = 'delegate/proof/';
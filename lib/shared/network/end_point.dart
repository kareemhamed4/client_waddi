// ignore_for_file: constant_identifier_names

const BASEURL = "http://192.168.1.12:8080/";

const LOGIN = "auth/login";
const USERREGISTER = "auth/register?type=personal";
const DRIVERREGISTER = "auth/register?type=comapny";
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
const DRIVERGETALLORDERS = "delegate/orders";
const DRIVERGETHISORDERS = 'delegate/delegate_orders';
const DRIVERTAKEORDERBYID = 'delegate/take_order/';
const DRIVERGETCURRENTORDER = 'delegate/orders/';
const DRIVERSEARCHORDERBYID = 'delegate/orders/';
const DRIVERCONFIRMORDER = 'delegate/confirm_order/';
const DRIVERSENDORDERPROOF = 'delegate/proof/';
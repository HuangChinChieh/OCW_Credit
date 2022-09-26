<%@ WebService Language="C#" Class="LobbyAPI" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Linq;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]
public class LobbyAPI : System.Web.Services.WebService {



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult HeartBeat(string GUID, string Echo) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

        return lobbyAPI.HeartBeat(GUID, Echo);
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult GetSIDParam(string WebSID, string GUID, string ParamName) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetSIDParam(GetToken(), WebSID, GUID, ParamName);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetSIDParam(string WebSID, string GUID, string ParamName, string ParamValue) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.SetSIDParam(GetToken(), WebSID, GUID, ParamName, ParamValue);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult KeepSID(string WebSID, string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.KeepSID(GetToken(), WebSID, GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.CASINO.APIResult CheckUserAccountByPhoneNumberAndLoginAccount(string GUID, string LoginAccount, string PhonePrefix, string PhoneNumber)
    {
        EWin.CASINO.CASINO3651 casino3651 = new EWin.CASINO.CASINO3651();
        TelPhoneNormalize TN = new TelPhoneNormalize(PhonePrefix, PhoneNumber);
        return casino3651.CheckUserAccountByPhoneNumberAndLoginAccount(GetToken(), GUID, TN.PhonePrefix, TN.PhoneNumber, LoginAccount);

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CheckAccountExist(string GUID, string LoginAccount) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CheckAccountExist(GetToken(), GUID, LoginAccount);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CheckAccountExistByContactPhoneNumber(string GUID, string PhonePrefix,string PhoneNumber) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CheckAccountExistByContactPhoneNumber(GetToken(), GUID, PhonePrefix,PhoneNumber);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult RequireRegister(string GUID, string ParentPersonCode, EWin.Lobby.PropertySet[] PS, EWin.Lobby.UserBankCard[] UBC) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.RequireRegister(GetToken(), GUID, ParentPersonCode, PS, UBC);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CreateAccount(string GUID, string LoginAccount, string LoginPassword, string ParentPersonCode, string CurrencyList, EWin.Lobby.PropertySet[] PS) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CreateAccount(GetToken(), GUID, LoginAccount, LoginPassword, ParentPersonCode, CurrencyList, PS);
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult GetLoginAccount(string GUID, string PhonePrefix, string PhoneNumber) {
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() {
            Result = EWin.Lobby.enumResult.ERR
        };

        TelPhoneNormalize telPhoneNormalize = new TelPhoneNormalize(PhonePrefix, PhoneNumber);

        if (telPhoneNormalize.PhoneIsValid) {
            R.Result = EWin.Lobby.enumResult.OK;
            R.Message = telPhoneNormalize.PhonePrefix + telPhoneNormalize.PhoneNumber;

        } else {
            R.Result = EWin.Lobby.enumResult.ERR;
            R.Message = "NormalizeError";
        }

        return R;
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.CompanySiteResult GetCompanySite(string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetCompanySite(GetToken(), GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public LoginMessageResult GetLoginMessage(string GUID)
    {

        LoginMessageResult R = new LoginMessageResult() { Result = EWin.Lobby.enumResult.ERR };
        Newtonsoft.Json.Linq.JObject SettingData;
        SettingData = EWinWeb.GetSettingJObj();
        if (SettingData != null)
        {
            if (SettingData["LoginMessage"] != null)
            {
                R.Message = SettingData["LoginMessage"]["Message"].ToString();
                R.Version = SettingData["LoginMessage"]["Version"].ToString();
                R.Result = EWin.Lobby.enumResult.OK;
            }
            else
            {
                R.Result = EWin.Lobby.enumResult.ERR;
                R.Message = "NoData";
            }
        }
        else
        {
            R.Result = EWin.Lobby.enumResult.ERR;
            R.Message = "NoData";
        }

        return R;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.UserInfoResult GetUserInfo(string WebSID, string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetUserInfo(GetToken(), WebSID, GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.UserBalanceResult GetUserBalance(string WebSID, string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetUserBalance(GetToken(), WebSID, GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult GetCompanyMarqueeText(string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetCompanyMarqueeText(GetToken(), GUID);
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.GameOrderDetailListResult GetGameOrderDetailHistoryBySummaryDate(string WebSID, string GUID, string QueryDate) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetGameOrderDetailHistoryBySummaryDate(GetToken(), WebSID, GUID, QueryDate);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.GameOrderDetailListResult GetGameOrderHistoryBySummaryDateAndGameCode(string WebSID, string GUID, string QueryDate) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.GameOrderDetailListResult callResult = new EWin.Lobby.GameOrderDetailListResult();
        EWin.Lobby.GameOrderDetailListResult R;
        callResult = lobbyAPI.GetGameOrderDetailHistoryBySummaryDate(GetToken(), WebSID, GUID, QueryDate);
        if (callResult.Result == EWin.Lobby.enumResult.OK) {
            R = new EWin.Lobby.GameOrderDetailListResult() {
                Result = EWin.Lobby.enumResult.OK,
                GUID = GUID
            };

            R.DetailList = callResult.DetailList.GroupBy(x => new { x.GameCode, x.CurrencyType, x.SummaryDate }, x => x, (key, detail) => new EWin.Lobby.GameOrderDetail {
                GameCode = key.GameCode,
                ValidBetValue = detail.Sum(y => y.ValidBetValue),
                BuyChipValue = detail.Sum(y => y.BuyChipValue),
                RewardValue = detail.Sum(y => y.RewardValue),
                OrderValue = detail.Sum(y => y.OrderValue),
                SummaryType = detail.FirstOrDefault().SummaryType,
                GameAccountingCode = detail.FirstOrDefault().GameAccountingCode,
                CurrencyType = key.CurrencyType,
                LoginAccount = detail.FirstOrDefault().LoginAccount,
                RealName = detail.FirstOrDefault().RealName,
                SummaryDate = key.SummaryDate
            }).ToArray();

        } else {
            R = callResult;
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.OrderSummaryResult GetGameOrderSummaryHistoryGroupGameCode(string WebSID, string GUID, string QueryBeginDate, string QueryEndDate) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.OrderSummaryResult callResult = new EWin.Lobby.OrderSummaryResult();
        EWin.Lobby.OrderSummaryResult R;
        callResult = lobbyAPI.GetGameOrderSummaryHistory(GetToken(), WebSID, GUID, QueryBeginDate, QueryEndDate);
        if (callResult.Result == EWin.Lobby.enumResult.OK) {
            R = new EWin.Lobby.OrderSummaryResult() {
                Result = EWin.Lobby.enumResult.OK,
                GUID = GUID
            };

            R.SummaryList = callResult.SummaryList.GroupBy(x => new { x.CurrencyType, x.SummaryDate }, x => x, (key, sum) => new EWin.Lobby.OrderSummary {
                ValidBetValue = sum.Sum(y => y.ValidBetValue),
                RewardValue = sum.Sum(y => y.RewardValue),
                OrderValue = sum.Sum(y => y.OrderValue),
                TotalValidBetValue = sum.Sum(y => y.TotalValidBetValue),
                TotalRewardValue = sum.Sum(y => y.TotalRewardValue),
                TotalOrderValue = sum.Sum(y => y.TotalOrderValue),
                CurrencyType = key.CurrencyType,
                LoginAccount = sum.FirstOrDefault().LoginAccount,
                SummaryDate = key.SummaryDate
            }).ToArray();

        } else {
            R = callResult;
        }

        return R;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.OrderSummaryResult GetGameOrderSummaryHistory(string WebSID, string GUID, string QueryBeginDate, string QueryEndDate) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetGameOrderSummaryHistory(GetToken(),WebSID, GUID, QueryBeginDate, QueryEndDate);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetWalletPassword(string WebSID, string GUID, string LoginPassword, string NewWalletPassword) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.SetWalletPassword(GetToken(),WebSID, GUID, LoginPassword, NewWalletPassword);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetUserPassword(string WebSID, string GUID, string OldPassword, string NewPassword) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.SetUserPassword(GetToken(), WebSID, GUID, OldPassword, NewPassword);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SendCSMail(string WebSID, string GUID, string EMail, string Topic, string SendBody) {
        EWin.Lobby.APIResult R;
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.UserInfoResult userInfo= lobbyAPI.GetUserInfo(GetToken(),WebSID,GUID);
        if (string.IsNullOrEmpty(EMail) == false) {
            if (string.IsNullOrEmpty(Topic) == false && string.IsNullOrEmpty(SendBody) == false) {
                string returnMail = string.IsNullOrEmpty(EMail) ? userInfo.LoginAccount : EMail;
                string returnLoginAccount = string.IsNullOrEmpty(userInfo.LoginAccount) ? "" : userInfo.LoginAccount;
                //string subjectString = String.Format("問題分類：{0},回覆信箱：{1}", Topic, returnMail);
                //string bodyString = String.Format("問題分類：{0}\r\n"
                //                        + "問題內容：{1}\r\n"
                //                        + "回覆信箱：{2}\r\n"
                //                        + "相關帳號：{3}\r\n"
                //                        + "詢問時間：{4}\r\n"
                //                        , Topic, SendBody, returnMail, returnLoginAccount, DateTime.Now);
                string subjectString = String.Format("お問い合わせ類型：{0},お返事のメールアドレス：{1}", Topic, returnMail);
                string bodyString = String.Format("お問い合わせ類型：{0}\r\n"
                                        + "お問い合わせ内容：{1}\r\n"
                                        + "お返事のメールアドレス：{2}\r\n"
                                        + "アカウント：{3}\r\n"
                                        + "お問い合わせ時間：{4}\r\n"
                                        , Topic, SendBody, returnMail, returnLoginAccount, DateTime.Now);

                /*
                お問い合わせ類型:
                お問い合わせ内容:
                お返事のメールアドレス:
                アカウント:
                お問い合わせ時間:
                */
                CodingControl.SendMail("smtp.gmail.com", new System.Net.Mail.MailAddress("Service <service@casino-maharaja.com>"), new System.Net.Mail.MailAddress("service@casino-maharaja.com"), subjectString, bodyString, "service@casino-maharaja.com", "goufeeqyyyerefjn", "utf-8", true);

                R = new EWin.Lobby.APIResult() {
                    Result = EWin.Lobby.enumResult.OK,
                    Message = "",
                    GUID = GUID
                };
            } else {
                R = new EWin.Lobby.APIResult() {
                    Result = EWin.Lobby.enumResult.ERR,
                    Message = "SubjectOrSendBodyIsEmpty",
                    GUID = GUID
                };
            }
        } else {
            R = new EWin.Lobby.APIResult() {
                Result = EWin.Lobby.enumResult.ERR,
                Message = "EMailNotFind",
                GUID = GUID
            };
        }

        return R;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetUserPasswordByValidateCode(string GUID, EWin.Lobby.enumValidateType ValidateType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber, string ValidateCode, string NewPassword) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.SetUserPasswordByValidateCode(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber, ValidateCode, NewPassword);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.ValidateCodeResult SetValidateCode(string GUID, EWin.Lobby.enumValidateType ValidateType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);
    }



    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetValidateCodeByMail(string GUID, EWin.Lobby.enumValidateType ValidateType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber, CodingControl.enumSendMailType SendMailType) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.ValidateCodeResult validateCodeResult;
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { GUID = GUID, Result = EWin.Lobby.enumResult.ERR };

        validateCodeResult = lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);

        if (validateCodeResult.Result == EWin.Lobby.enumResult.OK) {
            R = SendMail(EMail, validateCodeResult.ValidateCode, R, SendMailType);
        } else {
            R.Result = validateCodeResult.Result;
            R.Message = validateCodeResult.Message;
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CheckValidateCode(string GUID, EWin.Lobby.enumValidateType ValidateType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber, string ValidateCode) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CheckValidateCode(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber, ValidateCode);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.PaymentResult GetPaymentHistory(string WebSID, string GUID, string BeginDate, string EndDate) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetPaymentHistory(GetToken(), WebSID, GUID, BeginDate, EndDate);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.CompanyExchangeResult GetCompanyExchange(string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetCompanyExchange(GetToken(), GUID);
    }

    private EWin.Lobby.APIResult SendMail(string EMail, string ValidateCode, EWin.Lobby.APIResult result, CodingControl.enumSendMailType SendMailType) {
        string Subject = string.Empty;
        string SendBody = string.Empty;
        Subject = "Verify Code";

        SendBody = CodingControl.GetEmailTemp(EMail, ValidateCode, SendMailType);

        try {
            //CodingControl.SendMail("smtp.gmail.com", new System.Net.Mail.MailAddress("Service <service@OCW888.com>"), new System.Net.Mail.MailAddress(EMail), Subject, SendBody, "service@OCW888.com", "koajejksxfyiwixx", "utf-8", true);
            CodingControl.SendMail("smtp.gmail.com", new System.Net.Mail.MailAddress("Service <service@casino-maharaja.com>"), new System.Net.Mail.MailAddress(EMail), Subject, SendBody, "service@casino-maharaja.com", "goufeeqyyyerefjn", "utf-8", true);
            result.Result = EWin.Lobby.enumResult.OK;
            result.Message = "";

        } catch (Exception ex) {
            result.Result = EWin.Lobby.enumResult.ERR;
            result.Message = "";
        }
        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetUserMail(string GUID, EWin.Lobby.enumValidateType ValidateType, CodingControl.enumSendMailType SendMailType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber,string SMSContent) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.ValidateCodeResult validateCodeResult;
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { GUID = GUID, Result = EWin.Lobby.enumResult.ERR };
        string ValidateCode = string.Empty;
        TelPhoneNormalize telPhoneNormalize = new TelPhoneNormalize(ContactPhonePrefix, ContactPhoneNumber);
        if (telPhoneNormalize != null) {
            ContactPhonePrefix = telPhoneNormalize.PhonePrefix;
            ContactPhoneNumber = telPhoneNormalize.PhoneNumber;
        }

        switch (SendMailType) {
            case CodingControl.enumSendMailType.Register:
                validateCodeResult = lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);
                if (validateCodeResult.Result == EWin.Lobby.enumResult.OK) {
                    ValidateCode = validateCodeResult.ValidateCode;
                }
                break;
            case CodingControl.enumSendMailType.ForgetPassword:
                validateCodeResult = lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);
                if (validateCodeResult.Result == EWin.Lobby.enumResult.OK) {
                    ValidateCode = validateCodeResult.ValidateCode;
                }
                break;
            case CodingControl.enumSendMailType.ThanksLetter:

                break;
        }

        switch (ValidateType) {
            case EWin.Lobby.enumValidateType.EMail:
                R = SendMail(EMail, ValidateCode, R, SendMailType);
                break;
            case EWin.Lobby.enumValidateType.PhoneNumber:
                SMSContent = string.Format(SMSContent, ValidateCode);

                R = SendSMS(GUID, "0", 0, ContactPhonePrefix + ContactPhoneNumber, SMSContent);
                break;
            default:
                break;
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SendSMS(string GUID, string SMSTypeCode, int RecvUserAccountID, string ContactNumber, string SendContent) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { GUID = GUID, Result = EWin.Lobby.enumResult.ERR };
        string ValidateCode = string.Empty;

        R = lobbyAPI.SendSMS(GetToken(), GUID, SMSTypeCode, RecvUserAccountID, ContactNumber, SendContent);

        return R;
    }

    private string GetToken() {
        string Token;
        int RValue;
        Random R = new Random();
        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        return Token;
    }

    public class BulletinBoardResult : EWin.Lobby.APIResult {
        public List<BulletinBoard> Datas { get; set; }
    }

    public class BulletinBoard {
        public int BulletinBoardID { get; set; }
        public string BulletinTitle { get; set; }
        public string BulletinContent { get; set; }
        public DateTime CreateDate { get; set; }
        public int State { get; set; }
    }

    public class LoginMessageResult : EWin.Lobby.APIResult
    {
        public string Message { get; set; }
        public string Version { get; set; }
    }
}
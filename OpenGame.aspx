<%@ Page Language="C#" %>

<%

    string GameBrand = Request["GameBrand"];
    string SID = Request["SID"];
    string CT = Request["CT"];
    string Lang = Request["Lang"];
    string CurrencyType = Request["CurrencyType"];
    string GameName = Request["GameName"];
    string HomeUrl = Request["HomeUrl"];
    string DemoPlay = string.IsNullOrEmpty(Request["DemoPlay"]) ? "0" : Request["DemoPlay"]; //不支援DEMO直接最外層判斷

    if (GameBrand == "EWin" && GameName == "EWinGaming") {
        if (DemoPlay == "0") {
            Response.Redirect(EWinWeb.EWinUrl + "/Game/Login.aspx?CT=" + HttpUtility.UrlEncode(CT) + "&Lang=" + Lang);
        } else {
            Response.Write("NotSupportDemo");
            Response.Flush();
            Response.End();
        }
    } else {
        Response.Redirect(EWinWeb.EWinUrl + "/API/GamePlatformAPI/" + GameBrand + "/UserLogin.aspx?SID=" + SID + "&Language=" + Lang + "&CurrencyType=" + CurrencyType + "&GameName=" + GameName + "&HomeUrl=" + HomeUrl + "&DemoPlay=" + DemoPlay);
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>
</head>

<body>
    <div class="loader-container">
        <div class="loader-box">
            <div class="loader-spinner">
                <div></div>
            </div>
            <div class="loader-text">Loading...</div>
        </div>
        <div class="loader-backdrop"></div>
    </div>
</body>
</html>

<%@ Page Language="C#" %>

<%
    if (EWinWeb.IsInMaintain()) {
        Response.Redirect("/Maintain.aspx");
    }

    string Token;
    int RValue;
    Random R = new Random();
    string Lang = "CHT";
    string SID = string.Empty;
    string CT = string.Empty;
    int RegisterType;
    int RegisterParentPersonCode;
    string Version = EWinWeb.Version;
    string Bulletin = string.Empty;
    string FileData = string.Empty;
    string isModify = "0";
    string[] stringSeparators = new string[] { "&&_" };
    string[] Separators;

    try {
        if (System.IO.File.Exists(Server.MapPath("/App_Data/Bulletin.txt"))) {
            FileData = System.IO.File.ReadAllText(Server.MapPath("/App_Data/Bulletin.txt"));
            if (string.IsNullOrEmpty(FileData) == false) {
                Separators = FileData.Split(stringSeparators, StringSplitOptions.None);
                Bulletin = Separators[0];
                Bulletin = Bulletin.Replace("\r", "<br />").Replace("\n", string.Empty);
                if (Separators.Length > 1) {
                    isModify = Separators[1];
                }

                if (isModify == "1") {
                    Response.Redirect("Maintain.aspx");
                }
            }
        }
    } catch (Exception ex) { };

    if (string.IsNullOrEmpty(Request["SID"]) == false)
        SID = Request["SID"];

    if (string.IsNullOrEmpty(Request["CT"]) == false)
        CT = Request["CT"];

    EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

    RValue = R.Next(100000, 9999999);
    Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());
    var CompanySite = lobbyAPI.GetCompanySite(Token, Guid.NewGuid().ToString());

    RegisterType = CompanySite.RegisterType;
    RegisterParentPersonCode = CompanySite.RegisterParentPersonCode;
    if (string.IsNullOrEmpty(Request["Lang"])) {
        string userLang = CodingControl.GetDefaultLanguage();

        if (userLang.ToUpper() == "zh-TW".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-HK".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-MO".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CHT".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CHS".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-SG".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh-CN".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "zh".ToUpper()) {
            Lang = "CHT";
        } else if (userLang.ToUpper() == "en-US".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en-CA".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en-PH".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "en".ToUpper()) {
            Lang = "ENG";
        } else if (userLang.ToUpper() == "ko-KR".ToUpper()) {
            Lang = "KOR";
        } else if (userLang.ToUpper() == "ko-KP".ToUpper()) {
            Lang = "KOR";
        } else if (userLang.ToUpper() == "ko".ToUpper()) {
            Lang = "KOR";
        } else if (userLang.ToUpper() == "vi".ToUpper()) {
            Lang = "VIET";
        } else if (userLang.ToUpper() == "vi-VN".ToUpper()) {
            Lang = "VIET";
        } else if (userLang.ToUpper() == "ja".ToUpper()) {
            Lang = "JPN";
        } else { Lang = "KOR"; }
    } else {
        Lang = Request["Lang"];
    }

%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>パラダイス</title>
    <meta name='keywords' content="パラダイス" />
    <meta name='description' content="パラダイス" />
    <meta property="og:site_name" content="パラダイス" />
    <meta property="og:title" content="パラダイス" />
    <meta property="og:Keyword" content="パラダイス" />
    <meta property="og:description" content="パラダイス" />
    <!--meta property="og:url" content="https://bbc117.com/" /-->
    <meta property="og:image" content="images/share_pic.png">
    <meta property="og:type" content="website" />
    <!-- Share image -->
    <link rel="image_src" href="images/share_pic.png">

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/layoutAdj.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/toast.css?<%:Version%>" type="text/css" />
    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="images/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/share_pic.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/share_pic.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/share_pic.png">
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="images/share_pic.png">
</head>
<% if (EWinWeb.IsTestSite == false) { %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<%--<script async src="https://www.googletagmanager.com/gtag/js?id=G-WRNSR38PQ7"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-097DC2GB6H');
</script>--%>
<% } %>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="Scripts/OutSrc/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="Scripts/OutSrc/js/script.js"></script>
<script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<%--<script type="text/javascript" src="<%=EWinWeb.EWinUrl %>/Scripts/jquery.min.1.7.js"></script>--%>
<script
    src="https://code.jquery.com/jquery-2.2.4.js"
    integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
    crossorigin="anonymous"></script>
<script type="text/javascript" src="/Scripts/PaymentAPI.js?<%:Version%>""></script>
<script type="text/javascript" src="/Scripts/LobbyAPI.js?<%:Version%>""></script>
<script type="text/javascript" src="/Scripts/GameCodeBridge.js?1"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lozad.js/1.16.0/lozad.min.js"></script>
<script type="text/javascript">
    var c = new common();
    var ui = new uiControl();
    var mlp;
    var mlpByGameCode;
    var mlpByGameBrand;
    var lobbyClient;
    var paymentClient;
    var needCheckLogin = false;
    var GCB;
    var SearchControll;
    var lastWalletList = null; // 記錄最後一次同步的錢包, 用來分析是否錢包有變動    
    var CompanyGameCategoryCodes = ["All"];
    var EWinWebInfo = {
        EWinUrl: "<%=EWinWeb.EWinUrl %>",
        EWinGameUrl: "<%=EWinWeb.EWinGameUrl %>",
        MainCurrencyType: "<%=EWinWeb.MainCurrencyType %>",
        RegisterCurrencyType: "<%=EWinWeb.RegisterCurrencyType %>",
        SID: "<%=SID%>",
        CT: "<%=CT%>",
        UserLogined: false,
        Lang: "<%=Lang%>",
        UserInfo: null,
        RegisterType: "<%=RegisterType%>",
        RegisterParentPersonCode: "<%=RegisterParentPersonCode%>",
        GameCodeList: {
            CategoryList: [],
            GameBrandList: [],
            GameList: null
        },
        DeviceType: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ? 1 : 0,
        IsOpenGame: false
    };

    var hasBulletin = <%=(string.IsNullOrEmpty(Bulletin) ? "false" : "true")%>;

    var messageModal;
    var SiteInfo;
    var selectedCurrency = '';
    var GameInfoModal;
    var v ="<%:Version%>";
    var ParentPersonCode = "";
    var test = "";

    var LobbyGameList;

    var ID = 0;

    //#region TOP API
    function API_GetGCB() {
        return GCB;
    }

    function API_GetWebInfo() {
        return EWinWebInfo;
    }

    function API_GetLang() {
        return EWinWebInfo.Lang;
    }

    function API_GetLobbyAPI() {
        return lobbyClient;
    }

    function API_GetPaymentAPI() {
        return paymentClient;
    }


    function API_GetCurrency() {
        return selectedCurrency;
    }

    function API_GetGameLang(type, gameBrand, gameName) {
        if (type == 0) {
            return gameBrand;
            //return mlpByGameBrand.getLanguageKey(gameBrand);
        } else if (type == 1) {
            return mlpByGameCode.getLanguageKey(gameBrand + "." + gameName);
        } else if (type == 2) {
            return mlpByGameCode.getLanguageKey(gameName);
        } else {
            return "";
        }
    }

    // 打開客服系統
    function API_OpenServiceChat() {
        if (!EWinWebInfo.UserLogined) {
            showMessageOK(mlp.getLanguageKey(""), mlp.getLanguageKey("請先登入"), function () {
                API_LoadPage("Login", "Login.aspx");
            });
        } else {
            var idChatDivE = document.getElementById("idChatDiv");
            var idChatFrameParent = document.getElementById("idChatFrameParent");
            var idChatFrame = document.createElement("IFRAME");

            if (idChatDivE.classList.contains("show")) {
                idChatDivE.classList.remove("show");
                idChatFrameParent.style.display = "none";
            }
            else {
                //<iframe id="idChatFrame" name="idChatFrame" class="ChatFrame" border="0" frameborder="0" marginwidth="0" marginheight="0" allowtransparency="no" scrolling="no"></iframe>
                if (idChatDivE.getAttribute("isLoad") != "1") {
                    idChatDivE.setAttribute("isLoad", "1");
                    idChatFrame.id = "idChatFrame";
                    idChatFrame.name = "idChatFrame";
                    idChatFrame.className = "ChatFrame";
                    idChatFrame.border = "0";
                    idChatFrame.frameBorder = "0";
                    idChatFrame.marginWidth = "0";
                    idChatFrame.marginHeight = "0";
                    idChatFrame.allowTransparency = "no";
                    idChatFrame.scrolling = "no";

                    idChatFrameParent.appendChild(idChatFrame);

                    idChatFrame.src = "ChatMain.aspx?" + "SID=" + EWinWebInfo.SID + "&Acc=" + EWinWebInfo.UserInfo.LoginAccount + "&Url=" + EWinWebInfo.EWinUrl;

                }

                idChatFrameParent.style.display = "";
                c.addClassName(idChatDivE, "show");

            }
        }
    }

    //打開熱門文章
    function API_OpenHotArticle() {
        openHotArticle();
    }

    function API_SetLogin(_SID, cb) {
        var sourceLogined = EWinWebInfo.UserLogined;
        checkUserLogin(_SID, function (logined) {
            var raiseCurrencyChange = false;
            updateBaseInfo();

            if (cb)
                cb(logined);

            if (sourceLogined == logined)
                notifyWindowEvent("LoginState", logined);

            if (raiseCurrencyChange)
                notifyWindowEvent("BalanceChange", logined);

        });
    }

    // 強制登出
    function API_Logout() {
        EWinWebInfo.UserInfo = null;
        EWinWebInfo.UserLogined = false;
        //EWinWebInfo.Token = null;
        //EWinWebInfo.SID = null;
        //window.localStorage.clear();
        window.sessionStorage.clear();
        delCookie("RecoverToken");
        delCookie("LoginAccount");
        delCookie("CT");
        delCookie("SID");
        window.location.href = "Refresh.aspx?index.aspx";
    }

    function API_RefreshUserInfo(cb) {
        checkUserLogin(EWinWebInfo.SID, function (logined) {
            updateBaseInfo();

            notifyWindowEvent("LoginState", logined);

            if (cb != null)
                cb();
        });
    }

    function API_ShowMask(text, scope, cbClick) {
        var IFramePage = document.getElementById("IFramePage");
        var fullScope = false;

        if (scope != null) {
            if ((scope == true) || (scope == "f") || (scope == "full"))
                fullScope = true;
        }

        if (fullScope == false)
            ui.showMask(IFramePage, text, cbClick);
        else
            ui.showMask(null, text, cbClick);
    }

    function API_HideMask() {
        ui.hideMask();
    }

    function API_LoadingStart() {
        $('.loader-container').show();
        $('.loader-backdrop').removeClass('is-show');
    }

    function API_LoadingEnd(type) {
        var footerDom = c.getTemplate("footer");
        if (document.getElementById("IFramePage").contentDocument) {
            if (type && type == 1) {

            } else {
                document.getElementById("IFramePage").contentDocument.body.appendChild(footerDom);
            }
        }
        $('.loader-backdrop').addClass('is-show');
        $('.loader-container').fadeOut(250, function () {
            $('.iframe-container').addClass('is-show');
        });
    }

    function API_OpenGameCode(gameBrand, gameName) {
        GCB.GetByGameCode(gameBrand + "." + gameName, (gameItem) => {
            var rtpInfoJson = gameItem.RTPInfo;
            var categ = gameItem.GameCategoryCode;

            var divMessageBox = document.getElementById("alertGameIntro");

            if (divMessageBox != null) {
                divMessageBox.querySelector(".gameRealName").innerText = API_GetGameLang(1, gameBrand, gameName);
                divMessageBox.querySelector(".GameID").innerText = c.padLeft(gameItem.GameID.toString(), 5);
                divMessageBox.querySelector(".GameImg").src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameBrand + "/PC/" + EWinWebInfo.Lang + "/" + gameName + ".png";
                divMessageBox.querySelector(".GameImg").onerror = new Function("setDefaultIcon('" + gameBrand + "', '" + gameName + "')");

                if (rtpInfoJson) {
                    let JSON_RTPInfo = JSON.parse(rtpInfoJson);
                    divMessageBox.querySelector(".game-rtp").classList.remove("is-hide");

                    if (JSON_RTPInfo["RTP"] == "0") {
                        divMessageBox.querySelector(".game-rtp").classList.add("is-hide");
                    } else {
                        divMessageBox.querySelector(".RtpContent").innerText = JSON_RTPInfo["RTP"];
                    }
                } else {
                    divMessageBox.querySelector(".game-rtp").classList.remove("is-hide");
                    divMessageBox.querySelector(".RtpContent").innerText = "-";
                }

                if (gameItem.IsFavo == 1) {
                    divMessageBox.querySelector(".game-myFavorite").classList.add("add");
                    divMessageBox.querySelector(".FavoText").innerText = mlp.getLanguageKey("移除最愛");
                } else {
                    divMessageBox.querySelector(".game-myFavorite").classList.remove("add");
                    divMessageBox.querySelector(".FavoText").innerText = mlp.getLanguageKey("加入我的最愛");
                }

                divMessageBox.querySelector(".game-myFavorite").onclick = new Function("favBtnEvent('" + gameBrand + "', '" + gameName + "')");

                //if (gameItem.AllowDemoPlay == 1) {
                //    divMessageBox.querySelector(".game-demo").classList.remove("is-hide");
                //    divMessageBox.querySelector(".game-demo").onclick = new Function("openDemo('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
                //} else {
                //    divMessageBox.querySelector(".game-demo").classList.add("is-hide");
                //}


                if (EWinWebInfo.UserLogined) {
                    divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("開始遊戲");
                    divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
                } else {
                    divMessageBox.querySelector(".game-login").innerText = mlp.getLanguageKey("登入玩遊戲");
                    divMessageBox.querySelector(".game-login").onclick = new Function("openGame('" + gameBrand + "', '" + gameName + "' , '" + categ + "')");
                }

                GameInfoModal.toggle();
            }
        });
    }

    function API_LoadPage(title, url, checkLogined) {
        if (EWinWebInfo.IsOpenGame) {
            EWinWebInfo.IsOpenGame = false;
            SwitchGameHeader(0)
        }

        if (checkLogined) {
            if (!EWinWebInfo.UserLogined) {
                showMessageOK(mlp.getLanguageKey("尚未登入"), mlp.getLanguageKey("請先登入"), function () {
                    GameInfoModal.hide();
                    window.sessionStorage.setItem("SrcPage", url);
                    API_LoadPage("Login", "Login.aspx");
                });
                return;
            }
        }

        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            // if (IFramePage.children.length > 0) {
            //var ifrm = IFramePage.children[0];

            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                //loadingStart();
                //上一頁針對iframe的問題，只能將loading的function都放於頁面中
                //API_LoadingStart(); 
                IFramePage.src = url;
                //IFramePage.

            }

        }
    }


    function API_CloseGamePage() {
        var GameIFDiv = document.querySelector(".GameHeader")
        var IFramePage = document.getElementById("GameIFramePage");

        GameIFDiv.classList.add("is-hide");

        if (IFramePage) {
            GameIFDiv.removeChild(IFramePage)
        }
    }


    function API_Home() {
        //Game
        API_LoadPage("Home", "Home.aspx");
    }

    function API_Reload() {
        //Game
        window.location.reload();
    }

    function API_GetGameList(type) {
        if (type) {
            if (type == 1) {
                return LobbyGameList.HotList;
            } else if (type == 2) {
                return LobbyGameList.NewList;
            }
        } else {
            return LobbyGameList;
        }
    }

    function API_ShowMessage(title, msg, cbOK, cbCancel) {
        return showMessage(title, msg, cbOK, cbCancel);
    }

    function API_ShowMessageOK(title, msg, cbOK) {
        return showMessageOK(title, msg, cbOK);
    }

    function API_NonCloseShowMessageOK(title, msg, cbOK) {
        return nonCloseShowMessageOK(title, msg, cbOK);
    }

    function API_ShowPartialHtml(title, pathName, isNeedLang, cbOK) {
        //return window.open(pathName);
        return showPartialHtml(title, pathName, isNeedLang, cbOK);
    }

    function API_ShowContactUs() {
        return showContactUs();
    }

    function API_changeAvatarImg(avatar) {
        if (avatar) {
            document.getElementById("idAvatarImg").src = "images/assets/avatar/" + avatar + ".jpg"
        }
    }

    function API_GetFavoGames() {
        return getFavoriteGames();
    }

    function API_SendSerivceMail(subject, body, email) {
        lobbyClient.SendCSMail(EWinWebInfo.SID, Math.uuid(), email, subject, body, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("已成功通知客服，將回信至您輸入或註冊的信箱"));
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout") {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), o);
                }
            }
        });
    }

    function API_RefreshPersonalFavo(gameCode, isAdded) {
        //if (!isAdded) {
        //    var index = Favos.indexOf(gameCode);

        //    if (index > -1) {
        //        Favos.splice(index, 1);
        //    }
        //} else if (isAdded) {
        //    var index = Favos.indexOf(gameCode);

        //    if (index == -1) {
        //        Favos.push(gameCode);
        //    }
        //}

        //lobbyClient.SetUserAccountProperty(EWinWebInfo.SID, Math.uuid(), "Favo", JSON.stringify(Favos), function (success, o) {
        //    if (success) {
        //        if (o.Result == 0) {
        //        }
        //    }
        //});

        notifyWindowEvent("RefreshPersonalFavo", { GameCode: gameCode, IsAdded: isAdded });
    }

    //#endregion

    function SwitchGameHeader(type, gameBrand, gameName, categ) {
        var headers = document.querySelectorAll(".header-container .header-inner");

        switch (type) {
            case 0:
                //Close

                for (var i = 0; i < headers.length; i++) {
                    var dom = headers[i];

                    if (dom.classList.contains("GameHeader")) {
                        dom.classList.add("is-hide");
                    } else {
                        dom.classList.remove("is-hide");
                    }
                }

                break;
            case 1:
                //Open          

                for (var i = 0; i < headers.length; i++) {
                    var dom = headers[i];

                    if (dom.classList.contains("GameHeader")) {
                        var logoDom = dom.querySelector(".GameLogo");
                        var nameDom = dom.querySelector(".GameName");
                        dom.classList.remove("is-hide");
                        logoDom.src = EWinWebInfo.EWinGameUrl + "/Lobby/images/lobby/logo/" + gameBrand + "/logoPC_" + categ + ".png";
                        logoDom.alt = gameBrand;
                        nameDom.innerText = API_GetGameLang(1, gameBrand, gameName);

                    } else {
                        dom.classList.add("is-hide");
                    }
                }

                break;
        }
    }

    function GameLoadPage(url, gameBrand, gameName) {
        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                API_LoadingStart();
                IFramePage.src = url;
                IFramePage.onload = function () {
                    API_LoadingEnd();
                }
            }
        }
    }

    function showMessage(title, message, cbOK, cbCancel) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            //var divMessageBoxTitle = divMessageBox.querySelector(".alertContact_Text");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox);
            }

            if (divMessageBox != null) {
                messageModal.toggle();

                if (divMessageBoxCloseButton != null) {
                    // divMessageBoxCloseButton.style.display = "inline";
                    divMessageBoxCloseButton.classList.remove("is-hide");
                    divMessageBoxCloseButton.onclick = function () {
                        messageModal.hide();

                        if (cbCancel != null) {
                            cbCancel();
                        }
                    }
                }

                if (divMessageBoxOKButton != null) {
                    //divMessageBoxOKButton.style.display = "inline";

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                //divMessageBoxTitle.innerHTML = title;
                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showMessageOK(title, message, cbOK) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            //var divMessageBoxTitle = divMessageBox.querySelector(".alertContact_Text");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox);
            }

            if (divMessageBox != null) {
                messageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {
                    //divMessageBoxOKButton.style.display = "inline";

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                //divMessageBoxTitle.innerHTML = title;
                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function nonCloseShowMessageOK(title, message, cbOK) {
        if ($("#nonClose_alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("nonClose_alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            //var divMessageBoxTitle = divMessageBox.querySelector(".alertContact_Text");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox);
            }

            if (divMessageBox != null) {
                messageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {
                    //divMessageBoxOKButton.style.display = "inline";

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBox.onclick = function () {
                    messageModal.hide();

                    if (cbOK != null)
                        cbOK();
                }

                //divMessageBoxTitle.innerHTML = title;
                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showMessageInGameInfo(title, message, cbOK, cbCancel) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            //var divMessageBoxTitle = divMessageBox.querySelector(".alertContact_Text");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            var modal = new bootstrap.Modal(divMessageBox);


            if (divMessageBox != null) {
                GameInfoModal.hide();
                modal.show();

                if (divMessageBoxCloseButton != null) {
                    // divMessageBoxCloseButton.style.display = "inline";
                    divMessageBoxCloseButton.classList.remove("is-hide");
                    divMessageBoxCloseButton.onclick = function () {
                        modal.hide();
                        GameInfoModal.show();
                        if (cbCancel != null) {
                            cbCancel();
                        }
                    }
                }

                if (divMessageBoxOKButton != null) {
                    //divMessageBoxOKButton.style.display = "inline";

                    divMessageBoxOKButton.onclick = function () {
                        modal.hide();
                        //GameInfoModal.show();
                        if (cbOK != null)
                            cbOK();
                    }
                }

                //divMessageBoxTitle.innerHTML = title;
                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showPartialHtml(title, pathName, isNeedLang, cbOK) {
        var realPath;
        var divMessageBox = document.getElementById("alertPartialHtml");
        var divMessageBoxOKButton = divMessageBox.querySelector(".alertPartialHtml_OK");
        var divMessageBoxTitle = divMessageBox.querySelector(".alertPartialHtml_Title");
        var divMessageBoxContent = divMessageBox.querySelector(".alertPartialHtml_Content");
        var modal = new bootstrap.Modal(divMessageBox);

        if (isNeedLang) {
            realPath = pathName + "_" + EWinWebInfo.Lang + ".html";
        } else {
            realPath = pathName + ".html";
        }

        if (divMessageBox != null) {
            if (divMessageBoxOKButton != null) {
                divMessageBoxOKButton.onclick = function () {
                    divMessageBoxContent.innerHTML = "";
                    modal.hide();

                    if (cbOK != null)
                        cbOK();
                }
            }

            divMessageBoxTitle.innerHTML = title;
            $(divMessageBoxContent).load(realPath);

            modal.toggle();
        }
    }

    function showContactUs() {
        var divMessageBox = document.getElementById("alertContactUs");
        var divMessageBoxCrossButton = divMessageBox.querySelector(".close");

        var modal = new bootstrap.Modal(divMessageBox);

        if (divMessageBox != null) {
            modal.toggle();
        }
    }

    function sendContactUs() {
        var contactUsDom = document.querySelector(".inbox_customerService");
        var subjectText = contactUsDom.querySelector(".contectUs_Subject").value;
        var emailText = contactUsDom.querySelector(".contectUs_Eamil").value;
        var bodyText = contactUsDom.querySelector(".contectUs_Body").value;
        var NickName = contactUsDom.querySelector(".contectUs_NickName").value;
        var Phone = contactUsDom.querySelector(".contectUs_Phone").value;
        //if (!NickName) {
        //contactUsDom.NickName.setCustomValidity(mlp.getLanguageKey("NickName"));
        //}

        API_SendSerivceMail(subjectText, "ニックネーム：" + NickName + "<br/>" + "携帯電話：" + Phone + "<br/>" + bodyText, emailText);
    }
    //Game

    function setDefaultIcon(brand, name) {
        var img = event.currentTarget;
        img.onerror = null;
        img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brand + "/PC/" + WebInfo.Lang + "/" + name + ".png";
    }

    function openGame(gameBrand, gameName, categ) {
        var alertSearch = $("#alertSearch");

        if (alertSearch.css("display") == "block") {
            alertSearchCloseButton.click();
        }

        if (!EWinWebInfo.UserLogined) {
            showMessageInGameInfo(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                GameInfoModal.hide();
                API_LoadPage("Login", "Login.aspx");
            }, null);
        } else {
            EWinWebInfo.IsOpenGame = true;

            GCB.AddPlayed(gameBrand + "." + gameName, function (success) {
                if (success) {

                }
            });

            GameInfoModal.hide();

            if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
                if (EWinWebInfo.DeviceType == 1) {
                    window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "_blank")
                } else {
                    SwitchGameHeader(1, gameBrand, gameName, categ);
                    GameLoadPage("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
                }
            } else {
                GCB.AddPlayed(gameBrand + "." + gameName, function (success) {
                    if (success) {

                    }
                });
                GameInfoModal.hide();
                window.open("/OpenGame.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "_blank")
            }
        }
    }

    function openDemo(gameBrand, gameName, categ) {
        EWinWebInfo.IsOpenGame = true;
        setGameCodeToMyGames(gameBrand, gameName);
        GameInfoModal.hide();

        if (gameBrand.toUpperCase() != "EWin".toUpperCase()) {
            if (EWinWebInfo.DeviceType == 1) {
                window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "_blank")
            } else {
                SwitchGameHeader(1, gameBrand, gameName, categ);
                GameLoadPage("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href);
            }
        } else {
            setGameCodeToMyGames(gameBrand, gameName);
            GameInfoModal.hide();
            window.open("/OpenGame.aspx?DemoPlay=1&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + window.location.href, "_blank")
        }
    }

    //FavoriteGame
    function favBtnEvent(gameBrand, gameName) {
        if (EWinWebInfo.UserLogined) {
            var btn = event.currentTarget;
            var gameCode = gameBrand + "." + gameName;

            event.stopPropagation();

            if ($(btn).hasClass("add")) {
                $(btn).removeClass("add");
                GCB.RemoveFavo(gameCode, function () {
                    window.parent.API_RefreshPersonalFavo(gameCode, false);
                });
            } else {
                $(btn).addClass("add");
                GCB.AddFavo(gameCode, function () {
                    window.parent.API_RefreshPersonalFavo(gameCode, true);
                });
            }
        } else {
            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                API_LoadPage("Login", "Login.aspx");
            }, null);
        }

    };

    function getCompanyGameCategoryCode() {
        GCB.GetGameCategoryCode((categoryCodeItem) => {
            if (CompanyGameCategoryCodes.indexOf(categoryCodeItem.GameCategoryCode) < 0) {
                CompanyGameCategoryCodes.push(categoryCodeItem.GameCategoryCode);
            }
        }, () => {
            //console.log("done");
        })
    }

    function getFavoriteGames() {
        var favoriteGamesStr = window.localStorage.getItem("FavoriteGames");
        var favoriteGames;

        if (favoriteGamesStr) {
            favoriteGames = JSON.parse(favoriteGamesStr);
        } else {
            favoriteGames = [];
        }

        return favoriteGames;
    }

    function setFavoriteGame(gameBrand, gameName, type) {
        var favoriteGames = getFavoriteGames();
        var favoriteGame = {
            GameBrand: gameBrand,
            GameName: gameName
        };
        debugger
        if (type == 0) {
            //add
            favoriteGames.splice(0, 0, favoriteGame);
            window.localStorage.setItem("FavoriteGames", JSON.stringify(favoriteGames));
        } else {
            //remove
            var index = favoriteGames.findIndex(x => x.GameBrand == gameBrand && x.GameName == gameName);
            if (index > -1) {
                favoriteGames.splice(index, 1);
            }

            window.localStorage.setItem("FavoriteGames", JSON.stringify(favoriteGames));
        }
    }

    function checkInFavoriteGame(gameBrand, gameName) {
        var FavoGames = getFavoriteGames();
        var index = FavoGames.findIndex(x => x.GameBrand == gameBrand && x.GameName == gameName);

        if (index > -1) {
            return true
        } else {
            return false;
        }
    }

    function copyText(copyVal) {
        navigator.clipboard.writeText(copyVal).then(
            () => {
                //window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功"))
            },
            () => {
                //window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗"))
            });
    }

    function checkUserLogin(SID, cb) {
        var guid = Math.uuid();

        lobbyClient.GetUserInfo(SID, guid, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    EWinWebInfo.SID = SID;
                    EWinWebInfo.UserLogined = true;
                    EWinWebInfo.UserInfo = o;

                    if (cb)
                        cb(true);
                } else {
                    if (o.Message == "InvalidSID" || o.Message == "InvalidWebSID") {
                        // login fail
                        EWinWebInfo.UserLogined = false;
                    } else {
                        EWinWebInfo.UserLogined = false;

                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                    }

                    if (cb)
                        cb(false);
                }
            } else {
                // 忽略 timeout 
            }
        });
    }

    function notifyWindowEvent(eventName, o) {
        var IFramePage = document.getElementById("IFramePage");

        if (IFramePage != null) {
            isDisplay = true;
            if (!EWinWebInfo.IsOpenGame) {
                if (IFramePage.contentWindow && IFramePage.contentWindow.EWinEventNotify) {
                    try {
                        IFramePage.contentWindow.EWinEventNotify(eventName, isDisplay, o)
                    } catch (e) {

                    }
                }
            }
        }
    }
    /**
     * ************************
     */
    function updateBaseInfo() {
        var idMenuLogin = document.getElementById("idMenuLogin");
        var idLoginBtn = document.getElementById("idLoginBtn");
        //var idUserNameTitle = document.getElementById("idUserNameTitle");
        var idWalletDiv = idMenuLogin.querySelector(".amount")
        if (EWinWebInfo.UserLogined) {
            var wallet = EWinWebInfo.UserInfo.WalletList.find(x => x.CurrencyType.toLocaleUpperCase() == EWinWebInfo.MainCurrencyType);


            // 已登入
            $('#navWalletGroup').removeClass('is-hide');
            idMenuLogin.classList.remove("is-hide");
            idLoginBtn.classList.add("is-hide");
            idWalletDiv.innerText = new BigNumber(wallet.PointValue).toFormat();
            selectedCurrency = wallet.CurrencyType;
            document.getElementById('idLogoutItem').classList.remove('is-hide');

            //idWalletDiv.insertAdjacentHTML('beforeend', `<div class="currencyDiv">${EWinWebInfo.UserInfo.WalletList[0].CurrencyType}</div><div class="balanceDiv">${EWinWebInfo.UserInfo.WalletList[0].PointValue}</div>`);
        } else {
            // 尚未登入
            idMenuLogin.classList.add("is-hide");
            idLoginBtn.classList.remove("is-hide");
            document.getElementById('idLogoutItem').classList.add('is-hide');

        }
    }

    function userRecover(cb) {

        var recoverToken = getCookie("RecoverToken");
        var LoginAccount = getCookie("LoginAccount");

        if ((recoverToken != null) && (recoverToken != "")) {
            var postData;

            //API_ShowMask(mlp.getLanguageKey("登入復原中"), "full");
            postData = encodeURI("RecoverToken=" + recoverToken + "&" + "LoginAccount=" + LoginAccount);
            c.callService("/LoginRecover.aspx?" + postData, null, function (success, o) {
                //API_HideMask();

                if (success) {
                    var obj = c.getJSON(o);

                    if (obj.ResultCode == 0) {
                        EWinWebInfo.SID = obj.SID;

                        setCookie("RecoverToken", obj.RecoverToken, 365);
                        setCookie("LoginAccount", obj.LoginAccount, 365);

                        API_RefreshUserInfo(function () {
                            updateBaseInfo();

                            if (cb)
                                cb(true);
                        });
                    } else {
                        EWinWebInfo.UserLogined = false;
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請重新登入"), function () {
                            API_Logout();
                        });

                        if (cb)
                            cb(false);
                    }
                } else {
                    if (o == "Timeout") {
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"));
                    } else {
                        showMessageOK(mlp.getLanguageKey("錯誤"), o);
                    }

                    if (cb)
                        cb(false);
                }
            });
        }
    }

    function setLanguage(c, cb) {
        EWinWebInfo.Lang = c;
        window.localStorage.setItem("Lang", c);

        mlp.loadLanguage(c, function () {
            if (cb)
                cb();
        });

        mlpByGameCode.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameCode.", c, function () {
            notifyWindowEvent("SetLanguage", c);
        });
        //mlpByGameBrand.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameBrand.", c);      
    }

    function switchLang(Lang, isReload) {
        var LangText;

        switch (Lang) {
            case "JPN":
                LangText = "日本語";
                break;
            case "KOR":
                LangText = "한국어";
                break;
            case "CHT":
                LangText = "繁體中文";
                break;
            case "ENG":
                LangText = "English";
                break;
            case "CHS":
                LangText = "簡體中文";
                break;
            case "VIET":
                LangText = "Tiếng Việt";
                break;
            default:
                LangText = "한국어";
                break;
        }

        document.getElementById("idLangText").innerText = LangText;
        if (isReload) {
            setLanguage(Lang);
        }
    }

    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    //刪除cookie
    function delCookie(name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        cval = getCookie(name);
        if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
    }

    function onBtnLoginShow() {
        API_LoadPage("Login", "Login.aspx");
    }

    function init() {
        if (self != top) {
            window.parent.API_LoadingStart();
        }
        mlp = new multiLanguage(v);
        mlpByGameCode = new multiLanguage(v);
        lobbyClient = new LobbyAPI("/API/LobbyAPI.asmx");
        paymentClient = new PaymentAPI("/API/PaymentAPI.asmx");

        //mlpByGameBrand = new multiLanguage();

        if (window.localStorage.getItem("Lang")) {
            EWinWebInfo.Lang = window.localStorage.getItem("Lang");
        }

        GCB = new GameCodeBridge("/API/LobbyAPI.asmx", 30,
            {
                GameCode: "EWin.EWinGaming",
                GameBrand: "EWin",
                GameStatus: 0,
                GameID: 0,
                GameName: "EWinGaming",
                GameCategoryCode: "Live",
                GameCategorySubCode: "Baccarat",
                GameAccountingCode: null,
                AllowDemoPlay: 1,
                RTPInfo: "",
                IsHot: 1,
                IsNew: 1,
                SortIndex: 99,
                Tags: [],
                Language: [{
                    LanguageCode: "JPN",
                    DisplayText: "EWinゲーミング"
                },
                {
                    LanguageCode: "CHT",
                    DisplayText: "真人百家樂(eWIN)"
                }],
                RTP: null
            },
            () => {
                notifyWindowEvent("GameLoadEnd", null);
            }
        );

        //getCompanyGameCategoryCode();

        SearchControll = new searchControlInit("alertSearch");

        switchLang(EWinWebInfo.Lang, false);

        mlp.loadLanguage(EWinWebInfo.Lang, function () {

            mlpByGameCode.loadLanguageByOtherFile(EWinWebInfo.EWinUrl + "/GameCode.", EWinWebInfo.Lang, function () {
                var dstPage = c.getParameter("DstPage");

                if (dstPage) {
                    var loadPage;
                    switch (dstPage.toUpperCase()) {
                        case "Home".toUpperCase():
                            loadPage = "Home";
                            break;
                        case "Reg".toUpperCase():
                            loadPage = "register";
                            break;
                        case "Login".toUpperCase():
                            loadPage = "Login";
                            break;
                        default:
                            loadPage = "Home";
                            break;
                    }

                    history.replaceState(null, null, "?" + c.removeParameter("DstPage"));
                    API_LoadPage(loadPage, loadPage + ".aspx");

                } else {
                    API_Home();
                }

                //getCompanyGameCode();

                //登入Check
                window.setTimeout(function () {
                    lobbyClient.GetCompanySite(Math.uuid(), function (success, o) {
                        if (success) {
                            if (o.Result == 0) {
                                SiteInfo = o;
                                if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                    API_SetLogin(EWinWebInfo.SID, function (logined) {
                                        if (logined == false) {
                                            userRecover();
                                        } else {
                                            var srcPage = window.sessionStorage.getItem("SrcPage");

                                            if (srcPage) {
                                                window.sessionStorage.removeItem("SrcPage");
                                                API_LoadPage("SrcPage", srcPage, true);
                                            }
                                        }
                                    });
                                } else {
                                    updateBaseInfo();
                                }
                                API_HideMask();
                                //if (cb)
                                //    cb(true);
                            } else {
                                if (o.Message == "InvalidSID") {
                                    // login fail
                                    EWinWebInfo.UserLogined = false;
                                } else {
                                    EWinWebInfo.UserLogined = false;

                                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                                }


                            }
                        }
                        else {
                            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                                window.location.href = "index.aspx"
                            });
                        }

                    })
                }, 500);

                window.setInterval(function () {
                    // refresh SID and Token;
                    var guid = Math.uuid();

                    if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                        lobbyClient.KeepSID(EWinWebInfo.SID, guid, function (success, o) {
                            if (success == true) {
                                if (o.ResultCode == 0) {
                                    needCheckLogin = true;
                                } else {
                                    if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                        needCheckLogin = true;
                                    }
                                }
                            }
                        });

                    }
                }, 10000);

                window.setInterval(function () {
                    if (needCheckLogin == true) {
                        needCheckLogin = false;

                        if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                            API_SetLogin(EWinWebInfo.SID, function (logined) {
                                if (logined == false) {
                                    userRecover();
                                }
                            });
                        } else {
                            updateBaseInfo();
                        }
                    }
                }, 1000);
            });
        });

        API_changeAvatarImg(getCookie("selectAvatar"));

        GameInfoModal = new bootstrap.Modal(document.getElementById("alertGameIntro"));

    }

    function getCompanyGameCode(cb) {
        LobbyGameList = {
            HotList: [{ Description: "EWin", Categ: "Live", SubCateg: "Baccarat", GameBrand: "EWin", GameName: "EWinGaming", GameID: "0", IsHot: 1, IsNew: 0, RTPInfo: '{ "RTP": "0" }', AllowDemoPlay: 0 }],
            NewList: [],
            CategoryList: [{
                Categ: "All",
                SubCategList: ["Baccarat"],
                CategBrandList: ["EWin"]
            }, {
                Categ: "Live",
                SubCategList: ["Baccarat"],
                CategBrandList: ["EWin"]
            }],
            GameList: [{ Description: "EWin", Categ: "Live", SubCateg: "Baccarat", GameBrand: "EWin", GameName: "EWinGaming", GameID: "0", IsHot: 1, IsNew: 0, RTPInfo: '{ "RTP": "0" }', AllowDemoPlay: 0 }],
        };

        lobbyClient.GetCompanyGameCode(Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    //WebInfo.GameCodeList = o.GameCodeList;
                    o.GameCodeList.forEach(e => {
                        var tempSubCateg;

                        if (e.GameCategorySubCode == '') {
                            tempSubCateg = 'Other';
                        } else {
                            tempSubCateg = e.GameCategorySubCode;
                        }

                        var gameData = {
                            GameName: e.GameName,
                            GameBrand: e.BrandCode,
                            GameID: e.GameID,
                            Description: e.GameName,
                            Categ: e.GameCategoryCode,
                            SubCateg: tempSubCateg,
                            IsHot: e.IsHot,
                            IsNew: e.IsNew,
                            RTPInfo: e.RTPInfo,
                            AllowDemoPlay: e.AllowDemoPlay
                        };

                        if (e.IsNew == 1) {
                            LobbyGameList.NewList.push(gameData);
                        }

                        if (e.IsHot == 1) {
                            LobbyGameList.HotList.push(gameData);
                        }

                        //all
                        if (LobbyGameList.CategoryList[0].CategBrandList.find(eb => eb == e.BrandCode) == undefined)
                            LobbyGameList.CategoryList[0].CategBrandList.push(e.BrandCode);

                        if (LobbyGameList.CategoryList[0].SubCategList.find(eb => eb == tempSubCateg) == undefined)
                            LobbyGameList.CategoryList[0].SubCategList.push(tempSubCateg);

                        if (LobbyGameList.CategoryList.find(eb => eb.Categ == e.GameCategoryCode) == undefined) {
                            let data = {
                                Categ: e.GameCategoryCode,
                                SubCategList: [tempSubCateg],
                                CategBrandList: [
                                    e.BrandCode
                                ]
                            }
                            LobbyGameList.CategoryList.push(data);
                        } else {
                            LobbyGameList.CategoryList.forEach(cl => {
                                if (cl.Categ == e.GameCategoryCode) {
                                    if (cl.CategBrandList.find(cbl => cbl == e.BrandCode) == undefined)
                                        cl.CategBrandList.push(e.BrandCode)

                                    if (cl.SubCategList.find(cbl => cbl == tempSubCateg) == undefined)
                                        cl.SubCategList.push(tempSubCateg)
                                }
                            })
                        }

                        LobbyGameList.GameList.push(gameData);
                    }
                    );
                } else {
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("獲取遊戲資料錯誤") + ":" + mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout")
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新操作"));
                else
                    if ((o != null) && (o != ""))
                        alert(o);
            }

            if (cb)
                cb(success);
        });
    }

    function showErrorPage() {
        $('#system-msg').show();
    }

    function openHotArticle() {
        var orgin = "guides";
        switch (EWinWebInfo.Lang) {
            case "JPN":
                orgin = "Article/" + orgin + "_jp.html";
                break;
            case "ENG":
                orgin = "Article/" + orgin + "_en.html";
                break;
            case "CHT":
                orgin = "Article/" + orgin + ".html";
                break;
            default:
                orgin = "Article/" + orgin + ".html";
                break;
        }
        API_LoadingStart();
        API_LoadPage("Article", orgin);
    }

    function setGameCodeToMyGames(gameBrand, gameName) {
        var objMyGame = new Object();
        objMyGame.GameBrand = gameBrand;
        objMyGame.GameName = gameName;

        if (!localStorage.getItem('MyGames')) {
            var arrayMyGames = new Array();
            arrayMyGames.push(objMyGame);
            localStorage.setItem('MyGames', JSON.stringify(arrayMyGames));
        } else {
            var arrayMyGames = JSON.parse(localStorage.getItem('MyGames'));
            var isDuplicate = false;
            for (var i = 0; i < arrayMyGames.length; i++) {
                if (arrayMyGames[i].GameBrand == gameBrand && arrayMyGames[i].GameName == gameName) {
                    isDuplicate = true;
                    break;
                }
            }

            if (!isDuplicate) {
                if (arrayMyGames.length == 14) {
                    arrayMyGames.pop();
                    arrayMyGames.unshift(objMyGame);
                } else {
                    arrayMyGames.unshift(objMyGame);
                }
            }

            localStorage.setItem('MyGames', JSON.stringify(arrayMyGames));
        }

        if (document.getElementById('IFramePage').contentWindow.refreshMyGmae) {
            document.getElementById('IFramePage').contentWindow.refreshMyGmae();
        }

    }

    // 打開客服系統
    function openServiceChat() {
        var idChatDivE = document.getElementById("idChatDiv");
        var idChatFrameParent = document.getElementById("idChatFrameParent");
        var idChatFrame = document.createElement("IFRAME");

        if (idChatDivE.classList.contains("show")) {
            idChatDivE.classList.remove("show");
            idChatFrameParent.style.display = "none";
        }
        else {
            //<iframe id="idChatFrame" name="idChatFrame" class="ChatFrame" border="0" frameborder="0" marginwidth="0" marginheight="0" allowtransparency="no" scrolling="no"></iframe>
            if (idChatDivE.getAttribute("isLoad") != "1") {
                idChatDivE.setAttribute("isLoad", "1");
                idChatFrame.id = "idChatFrame";
                idChatFrame.name = "idChatFrame";
                idChatFrame.className = "ChatFrame";
                idChatFrame.border = "0";
                idChatFrame.frameBorder = "0";
                idChatFrame.marginWidth = "0";
                idChatFrame.marginHeight = "0";
                idChatFrame.allowTransparency = "no";
                idChatFrame.scrolling = "no";

                idChatFrameParent.appendChild(idChatFrame);

                idChatFrame.src = "ChatMain.aspx?SID=" + EWinWebInfo.SID + "&Acc=" + EWinWebInfo.UserInfo.LoginAccount + "&Url=" + EWinWebInfo.EWinUrl;
            }

            idChatFrameParent.style.display = "";
            c.addClassName(idChatDivE, "show");

        }
    }

    function sleep(time) {
        return new Promise((resolve) => setTimeout(resolve, time));
    }

    //#region 搜尋彈出

    function searchControlInit(searchDomID) {
        var SearchSelf = this;
        var SearchDom = $("#" + searchDomID);
        var showMoreClickCount = 1;

        this.searchGameList = function (gameBrand) {
            var arrayGameBrand = [];
            var gameBrand;
            var keyWord = SearchDom.find('#alertSearchKeyWord').val().trim();
            var gamecategory = SearchDom.find("#seleGameCategory").val() == "All" ? "" : $("#seleGameCategory").val();
            var lang = EWinWebInfo.Lang;
            var alertSearchContent = SearchDom.find('#alertSearchContent');
            var gameItemCount = 0;
            showMoreClickCount = 1;

            alertSearchContent.empty();

            if (gameBrand) {
                arrayGameBrand.push(gameBrand);
            } else {
                SearchDom.find("input[name='button-brandExchange']").each(function (e, v) {
                    if ($(v).prop("checked")) {
                        arrayGameBrand.push($(v).attr('id').split("_")[1]);
                    }
                });
            }

            if (arrayGameBrand.length == 0 && gamecategory == "" && keyWord == "") {
                showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請選擇／輸入其中一項"));
            } else {
                GCB.CursorGetByMultiSearch2(arrayGameBrand, gamecategory, null, keyWord,
                    function (gameItem) {

                        var RTP = "--";
                        var lang_gamename = gameItem.Language.find(x => x.LanguageCode == EWinWebInfo.Lang) ? gameItem.Language.find(x => x.LanguageCode == EWinWebInfo.Lang).DisplayText : "";
                        lang_gamename = lang_gamename.replace("'", "");
                        if (gameItem.RTPInfo) {
                            RTP = JSON.parse(gameItem.RTPInfo).RTP;
                        }

                        if (RTP == "0") {
                            RTP = "--";
                        }

                        GI = c.getTemplate("tmpSearchGameItem");
                        let GI1 = $(GI);
                        GI.onclick = new Function("openGame('" + gameItem.GameBrand + "', '" + gameItem.GameName + "','" + gameItem.GameCategoryCode + "')");

                        GI1.addClass("group" + parseInt(gameItemCount / 60));
                        gameItemCount++;
                        var GI_img = GI.querySelector(".gameimg");
                        if (GI_img != null) {
                            GI_img.src = EWinWebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + lang + "/" + gameItem.GameName + ".png";
                            var el = GI_img;
                            var observer = lozad(el); // passing a `NodeList` (e.g. `document.querySelectorAll()`) is also valid
                            observer.observe();
                        }

                        var likebtn = GI.querySelector(".btn-like");

                        if (EWinWebInfo.DeviceType == 0) {
                            $(likebtn).addClass("desktop");
                        }

                        if (gameItem.FavoTimeStamp) {

                            $(likebtn).addClass("added");
                        } else {
                            $(likebtn).removeClass("added");
                        }

                        likebtn.onclick = new Function("favBtnClick('" + gameItem.GameCode + "')");

                        GI1.find(".gameName").text(lang_gamename);
                        GI1.find(".BrandName").text(mlp.getLanguageKey(gameItem.GameBrand));
                        GI1.find(".valueRTP").text(RTP);
                        GI1.find(".valueID").text(gameItem.GameID);
                        GI1.find(".GameCategoryCode").text(mlp.getLanguageKey(gameItem.GameCategoryCode));

                        if (gameItemCount < 61) {
                            alertSearchContent.append(GI);
                        } else {
                            GI1.css("display", "none");
                            alertSearchContent.append(GI);
                        }

                    }, function (data) {
                        if (alertSearchContent.children().length == 0) {
                            alertSearchContent.append(`<div class="no-Data"><div class="data"><span class="text language_replace">${mlp.getLanguageKey("沒有資料")}</span></div></div>`);
                        } else if (alertSearchContent.children().length > 60) {
                            alertSearchContent.append(`<div style="width: 100%;display: block;"></div><div class="s-btn-more" onclick="SearchControll.rem()">${mlp.getLanguageKey("查看更多")}</div>`);
                        }
                    }
                )
            }
        };
        this.rem = function () {
            if (SearchDom.children().find(".group" + showMoreClickCount).length > 0) {
                SearchDom.children().find(".group" + showMoreClickCount).show();
            }

            showMoreClickCount++;

            if (SearchDom.children().find(".group" + showMoreClickCount).length == 0) {
                $(event.currentTarget).remove();
            }
        }

        this.searchGameChange = function (cb) {
            var keyWord = SearchDom.find('#alertSearchKeyWord').val().trim();
            var arrayGameBrand = [];
            let strSeleBrandText = SearchDom.find(".brandSeleCount");
            let kk = "";
            var seleGameCategory = SearchDom.find("#seleGameCategory");
            let allGameBrandLength = $("#alertSearch").find("input[name='button-brandExchange']").length;

            SearchDom.find("input[name='button-brandExchange']").each(function (e, v) {
                if ($(v).prop("checked")) {
                    arrayGameBrand.push($(v).attr('id').split("_")[1]);
                }
            });

            //if (arrayGameBrand.length == 0 && keyWord == "") {
            //    SearchDom.find("#div_SearchGameCategory").hide();
            //} else {
            //    SearchDom.find("#div_SearchGameCategory").show();
            //}
            if (arrayGameBrand.length == 0 || arrayGameBrand.length == allGameBrandLength) {
                strSeleBrandText.text(mlp.getLanguageKey("全部"));
            } else {
                strSeleBrandText.text(` ${arrayGameBrand.length} / ${allGameBrandLength} `);
            }

            var o;
            seleGameCategory.empty();
            o = new Option(mlp.getLanguageKey("全部"), "All");
            seleGameCategory.append(o);

            if (arrayGameBrand.length > 0) {
                for (var k = 0; k < arrayGameBrand.length; k++) {

                    GCB.CursorGetGameCategoryCodeByGameBrand(arrayGameBrand[k],
                        function (data) {
                            if (kk.indexOf(data.GameCategoryCode) < 0) {
                                kk += data.GameCategoryCode + ",";

                                o = new Option(mlp.getLanguageKey(data.GameCategoryCode), data.GameCategoryCode);
                                seleGameCategory.append(o);
                            }
                        }, function (data) { //endcallback
                            if (cb) {
                                cb();
                            }
                        }
                    );
                }
            }
        }

        this.searchGameChangeClear = function () {
            var alertSearchContent = SearchDom.find('#alertSearchContent');
            resetSeleGameCategory();
            SearchDom.find("#alertSearchKeyWord").val("");
            SearchDom.find(".brandSeleCount").text(mlp.getLanguageKey("全部"));
            SearchDom.find("input[name='button-brandExchange']").each(function (e, v) {
                $(v).prop("checked", false);
            });

            alertSearchContent.empty();
        }

        this.searchGameChangeConfirm = function () {

            SearchDom.find('.input-fake-select').toggleClass('show');
            SearchDom.find('.input-fake-select').parents('.searchFilter-wrapper').find('.brand-wrapper').slideToggle();
            SearchDom.find('.mask-header').toggleClass('show');
            SearchSelf.searchGameList();
        }

        this.searchGameByBrand = function (gameBrand) {
            SearchDom.find("input[name='button-brandExchange']").each(function (e, v) {
                $(v).prop("checked", false);
            });

            if (SearchDom.find('#searchIcon_' + gameBrand).length > 0) {
                SearchDom.find('#searchIcon_' + gameBrand).prop("checked", true);
            }

            SearchDom.find('#alertSearchKeyWord').val('');
            SearchDom.find("#seleGameCategory").val('');
            SearchDom.modal('show');
            SearchSelf.searchGameList(gameBrand);
        }

        this.searchGameByBrandAndGameCategory = function (gameBrand, gameCategoryName) {
            //待修正
            let o;

            SearchDom.modal('show');
            SearchDom.find("#div_SearchGameCategory").show();
            SearchDom.find("input[name='button-brandExchange']").each(function (e, v) {
                $(v).prop("checked", false);
            });

            for (var i = 0; i < gameBrand.length; i++) {
                if (SearchDom.find('#searchIcon_' + gameBrand[i]).length > 0) {
                    SearchDom.find('#searchIcon_' + gameBrand[i]).prop("checked", true);
                }
            }


            SearchDom.find("#seleGameCategory").empty();
            o = new Option(mlp.getLanguageKey("全部"), "All");
            SearchDom.find("#seleGameCategory").append(o);
            SearchDom.find("#seleGameCategory").val("All");

            if (gameCategoryName) {
                o = new Option(mlp.getLanguageKey(gameCategoryName), gameCategoryName);
                SearchDom.find("#seleGameCategory").append(o);
                SearchDom.find("#seleGameCategory").val(gameCategoryName);
            }

            SearchDom.find('#alertSearchKeyWord').val('');

            SearchSelf.searchGameList();

        }

        //openFullSearch
        this.openFullSearch = function (e) {
            var header_SearchFull = document.getElementById("header_SearchFull");
            header_SearchFull.classList.add("open");
        }

        //openFullSearch
        this.closeFullSearch = function (e) {
            var header_SearchFull = document.getElementById("header_SearchFull");

            if (header_SearchFull.classList.contains("open")) {
                header_SearchFull.classList.remove("open");
            }
        }

        var getSearchGameBrand = function () {
            var ParentMain = SearchDom.find("#ulSearchGameBrand");
            ParentMain.empty();

            lobbyClient.GetGameBrand(Math.uuid(), function (success, o) {
                if (success == true) {
                    if (o.Result == 0) {
                        let GBLDom;
                        let GBL_img;

                        GBLDom = c.getTemplate("tmpSearchGameBrand");
                        GBL_img = GBLDom.querySelector(".brandImg");
                        $(GBLDom).find(".searchGameBrandcheckbox").attr("id", "searchIcon_EWin");
                        GBL_img.src = `images/logo/default/logo-eWIN.svg`;
                        ParentMain.append(GBLDom);

                        for (var i = 0; i < o.GameBrandList.length; i++) {
                            let GBL = o.GameBrandList[i];
                            if (GBL.GameBrandState == 0) {
                                GBLDom = c.getTemplate("tmpSearchGameBrand");
                                GBL_img = GBLDom.querySelector(".brandImg");

                                $(GBLDom).find(".searchGameBrandcheckbox").attr("id", "searchIcon_" + GBL.GameBrand);

                                if (GBL.GameBrandState == 0) {
                                    GBL_img.src = `images/logo/default/logo-${GBL.GameBrand}.png`;
                                }

                                ParentMain.append(GBLDom);
                            }
                        }
                    } else {

                    }
                }
            });
        }

        var resetSeleGameCategory = function () {
            var seleGameCategory = SearchDom.find("#seleGameCategory");
            var o;

            seleGameCategory.empty();

            o = new Option(mlp.getLanguageKey("全部"), "All");
            seleGameCategory.append(o);
            o = new Option(mlp.getLanguageKey("Electron"), "Electron");
            seleGameCategory.append(o);
            o = new Option(mlp.getLanguageKey("Fish"), "Fish");
            seleGameCategory.append(o);
            o = new Option(mlp.getLanguageKey("Live"), "Live");
            seleGameCategory.append(o);
            o = new Option(mlp.getLanguageKey("Slot"), "Slot");
            seleGameCategory.append(o);
            o = new Option(mlp.getLanguageKey("Sports"), "Sports");
            seleGameCategory.append(o);

            seleGameCategory.val("All");
        }

        function init() {
            getSearchGameBrand();
        }

        init();
    };

    //#endregion

        function favBtnClick(gameCode) {
        if (EWinWebInfo.UserLogined) {
            var btn = event.currentTarget;
            event.stopPropagation();

            if ($(btn).hasClass("added")) {
                $(btn).removeClass("added");
                GCB.RemoveFavo(gameCode, function () {
                    window.parent.API_RefreshPersonalFavo(gameCode, false);
                });
            } else {
                $(btn).addClass("added");
                GCB.AddFavo(gameCode, function () {
                    window.parent.API_RefreshPersonalFavo(gameCode, true);
                });
            }
        } else {
            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                API_LoadPage("Login", "Login.aspx");
            }, null);
        }

    }

    function setFavoriteGame(gameCode) {
        var favoriteGames = [];

        GCB.GetFavo(function (data) {
            favoriteGames.push(data);
        }, function (data) {
            if (!favoriteGames.filter(e => e.GameCode === gameCode).length > 0) {
                //ad
                GCB.AddFavo(gameCode);
            } else {
                //remove
                GCB.RemoveFavo(gameCode);
            }
        });
    }

    window.onload = init;
</script>

<body>
    <div class="loader-container" style="display: none">
        <div class="loader-box">
            <div class="loader-spinner">
                <div></div>
            </div>
            <div class="loader-text">Loading...</div>
        </div>
        <div class="loader-backdrop"></div>
    </div>

    <div class="wrapper">
        <!-- HEADER -->
        <div class="nav-toggle">
            <div></div>
        </div>
      
        <header class="header-container">
            <div class="header-inner ">
                <h1 class="header-logo" onclick="API_LoadPage('Home','Home.aspx')">
                    <img src="images/assets/logo_maharaja.svg" alt="maharaja">
                </h1>
                <div class="header_setting_content">
                     <!-- Search -->
                     <div class="navbar-search nav-item" style="display: ;">
                        <span class="search-bar desktop" data-toggle="modal" data-target="#alertSearch">
                            <span class="btn btn-search">
                                <i class="icon icon-mask icon-search"></i>
                            </span>
                            <span class="text language_replace">遊戲搜尋</span>
                        </span>
                    </div>
                    <div class="header-tool">
                        <div id="idMenuLogin" class="header-tool-item user is-hide">     
                            <div class="balance-container">
                                <div class="balance-inner">
                                    <div class="game-coin">  
                                        <!-- 未完成存款訂單小紅點 -->
                                        <%-- <span class="notify"><span class="notify-dot"></span></span>        --%>                              
                                        <img src="images/assets/coin-Ocoin.png" alt="">
                                    </div>
                                    <div class="currency-info" style="display:none">
                                        <div class="currencyType">KRW</div>
                                    </div>
                                    <div class="balance-info">
                                        <div class="amount">0</div>
                                    </div>
                                    <button class="btn btn-deposit" onclick="API_LoadPage('Deposit','Deposit.aspx', true)" style="display: none;">
                                        <span class="icon-add"></span>
                                    </button>
                                </div>
                            </div>                   
                           
                            <a class="item-tab MemberCenterBtn" onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)">
                                <div class="avatar">
                                    <img id="idAvatarImg" src="images/assets/avatar/avatar-05.jpg">
                                </div>
                            </a>
                        </div>
                        <div id="idLoginBtn" class="header-tool-item">
                            <a class="item-tab" onclick="onBtnLoginShow()">
                                <i class="icon-user-circle"></i>
                                <span class="language_replace">登入</span>
                            </a>
                        </div>
                        <div class="header-tool-item">
                            <a class="item-tab" data-btn-click="openLag">
                                <i class="icon-world"></i>
                                <span id="idLangText">繁體中文</span>
                            </a>
                            <div class="lang-select-panel">
                                <ul>
                                    <!-- <li><a onclick="switchLang('KOR', true)">한국어</a></li> -->
                                    <li><a onclick="switchLang('JPN', true)">日本語</a></li>
                                    <li><a onclick="switchLang('ENG', true)">EN</a></li>
                                    <li><a onclick="switchLang('CHT', true)">繁體中文</a></li>
                                    <!-- <li><a onclick="switchLang('CHS', true)">簡體中文</a></li>
                                    <li><a onclick="switchLang('VIET', true)">Tiếng Việt</a></li> -->
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="header-inner GameHeader is-hide">
                <h1 class="header-logo" onclick="API_LoadPage('Home','Home.aspx')">
                    <img src="images/assets/logo_maharaja.svg" alt="maharaja">
                </h1>
                <div class="header-gameName">
                    <div class="logo">
                        <div class="img-wrap">
                            <img class="GameLogo" src="" alt=""></div>
                    </div>
                    <span class="GameName"></span>
					<div class="gameClodeBtn btn btn-primary btn-sm" onclick="API_LoadPage('Home','Home.aspx')"><span class="language_replace">關閉遊戲</span></div>
                </div>
                <div class="header-tool" style="display: none;">
                </div>
            </div>
        </header>

        <!-- 客服中心iFRAME框 -->
        <div id="idChatDiv" class="chatDiv">
            <div class="chatHeader">
                <h4 class="chatTitle language_replace">線上客服</h4>
                <button class="btn btn-icon" onclick="closeChat(idChatDiv)">
                    <i class="icon-close-big"></i>
                </button>
                <!-- <div class="chatCloseBtn" onclick="closeChat(idChatDiv)">close</div> -->
            </div>
            <div id="idChatFrameParent" style="height: 100%; width: 100%;">
                <!--<iframe id="idChatFrame" name="idChatFrame" class="ChatFrame" border="0" frameborder="0" marginwidth="0" marginheight="0" allowtransparency="no" scrolling="no"></iframe>-->
            </div>
        </div>
        <!-- 關閉 客服中心-測試用 -->
        <script>
            function closeChat(e) {
                e.classList.remove("show");
            }
        </script>

        <!-- 主選單 -->
        <div class="nav">           
            <nav class="nav-drawer">
                <div class="search-bar mobile" data-toggle="modal" data-target="#alertSearch">
                    <span class="text language_replace">遊戲搜尋</span>
                    <span class="btn btn-search">
                        <i class="icon icon-mask icon-search"></i>
                    </span>
                </div>
                <div class="nav-drawer-inner">
                    <ul class="nav-group">
                        <li>
                            <a onclick="API_Home()">
                                <i class="icon-home"></i>
                                <span class="language_replace">首頁</span>
                            </a>
                        </li>
                          <li>
                            <a onclick="API_LoadPage('Casino', 'Casino.aspx?Category=Live')">
                                <i class="icon-casino"></i>
                                <span class="language_replace">真人</span>
                            </a>
                        </li>
                    <%--    <li>
                            <a onclick="API_LoadPage('Casino', 'Casino.aspx?Category=Sports')">
                                <i class="icon-casinoworld-football"></i>
                                <span class="language_replace">體育</span>
                            </a>
                        </li>--%>
                        <li>
                            <a onclick="API_LoadPage('Casino', 'Casino.aspx?Category=Slot')">
                                <i class="icon-slot"></i>
                                <span class="language_replace">老虎機</span>
                            </a>
                        </li>
                        <li style="display: none">
                            <a onclick="API_LoadPage('Casino', 'Casino.aspx?Category=Classic')">
                                <i class="icon-poker"></i>
                                <span class="language_replace">經典</span>
                            </a>
                        </li>
                        <li style="display: none">
                            <a onclick="openServiceChat()">
                                <i class="icon-casino"></i>
                                <span class="language_replace">客服測試</span>
                            </a>
                        </li>
                        <!-- <li>
                            <a href="">
                                <i class="icon-news"></i>
                                <span>新聞</span>
                            </a>
                        </li> -->
                        <li class="is-hide">
                            <a>
                                <i class="icon-wallet"></i>
                                <span class="language_replace">錢包</span>
                            </a>
                        </li>
                        <li>
                            <a onclick="API_LoadPage('GameHistory', 'GameHistory.aspx?1', true)">
                                <i class="icon-games"></i>
                                <span class="language_replace">遊戲紀錄</span>
                            </a>
                        </li>
                        <li>
                            <a onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)">
                                <i class="icon-member"></i>
                                <span class="language_replace">會員中心</span>
                            </a>
                        </li>
                        <li class="is-hide">
                            <a class="has-msg" data-btn-click="conversation">
                                <i class="icon-service"></i>
                                <span class="language_replace">客服</span>
                            </a>
                        </li>
                        <li>
                            <a onclick="API_LoadPage('About','About.html')">
                                <i class="icon-flag"></i>
                                <span class="language_replace">關於我們</span>
                            </a>
                        </li>
                        <li>
                            <a onclick="openHotArticle()">
                                <i class="icon-casinoworld-newspaper"></i>
                                <span class="language_replace">熱門文章</span>
                            </a>
                        </li>
                        <%--                        <li>
                            <a onclick="API_LoadPage('UserTransfer','UserTransfer.aspx')">
                                <i class="icon-flag"></i>
                                <span class="language_replace">金幣轉移</span>
                            </a>
                        </li>--%>
                    </ul>

                    <ul class="nav-group is-hide" id="navWalletGroup">
                    <%--    <li class="is-hide navDeposit">
                            <a onclick="API_LoadPage('Deposit','Deposit.aspx', true)">
                                <i class="icon-deposit"></i>
                                <span class="language_replace">存款</span>
                            </a>
                        </li>
                        <li>
                            <a onclick="API_LoadPage('Withdrawal','Withdrawal.aspx', true)">
                                <i class="icon-withdraw"></i>
                                <span class="language_replace">出款</span>
                            </a>
                        </li>
             
                         <li>
                            <a onclick="API_LoadPage('WalletCenter','WalletCenter.aspx', true)">
                                <i class="icon-wallet"></i>
                                <span class="language_replace">錢包中心</span>
                            </a>
                        </li>--%>
                        <!--li style="">
                            <a onclick="API_LoadPage('QA','/Article/guide_Q&A_jp.html')">
                                <i class="icon-service"></i>
                                <span class="language_replace">Q&A</span>
                            </a>
                        </li-->
                    </ul>

                    <ul id="idLogoutItem" class="nav-group is-hide">
                        <li>
                            <a class="btn-sign-out" data-btn-click="system-msg" onclick="API_Logout()">
                                <i class="icon-exit"></i>
                                <span class="language_replace">登出</span>
                            </a>
                        </li>
                    </ul>

                    <%-- <ul class="nav-group">
                        <li>
                            <a class="btn-sign-out" data-btn-click="system-msg" onclick="showErrorPage()">
                                <i class="icon-exit"></i>
                                <span class="language_replace">錯誤頁面測試</span>
                            </a>
                        </li>
                    </ul>--%>
                </div>

            </nav>
            <div class="body-backdrop"></div>
        </div>

        <!-- 登入/註冊 -->
        <div id="sign"></div>
        <!-- 客服對話 -->
        <div id="conversation"></div>
        <!-- 系統錯誤 -->
        <div id="system-msg" style="display: none">
            <div class="layout-full-screen system-msg-container">
                <div class="main-panel">
                    <section class="section-wrap">
                        <div class="logo">
                            <img src="images/assets/logo-icon.svg" alt="">
                        </div>
                        <div class="img-wrap img-error">
                            <img src="images/assets/feature-img-joker.svg">
                        </div>
                        <div class="text-wrap text-center">
                            <p>
                                <span class="language_replace">今はサイト点検中</span><br>
                                <span class="language_replace">しばらく待ってから、お戻りください。</span><br>
                                <br>
                                <span class="language_replace">メンテナンス時間: 月曜日の 11:00 ～13:00 (GMT+9)</span>
                            </p>
                            <!-- <p><span class="language_replace">您點選的頁面沒有反應，請回到首頁，</span><span class="break language_replace">或是進入我們為您精心準備的遊戲！</span></p> -->
                        </div>
                        <div class="btn-container">
                            <a href="index.aspx" class="square-link outline">
                                <i class="icon-home"></i>
                                <span class="language_replace">首頁</span>
                            </a>
                        </div>
                    </section>

                </div>
            </div>

        </div>

        <!-- page -->
        <div class="iframe-container">
            <iframe id="IFramePage" frameborder="0" name="page"></iframe>
        </div>
        <%--        <div id="GameIFrameParentDiv" class="is-hide" style="z-index: 9999; position: absolute; top: 64px; height: calc(100vh - 64px); width: 100vw">
        </div>--%>
    </div>
    <!-- footer -->
    <div id="footer" class="is-hide">
        <footer class="footer-container">
            <div class="footer-inner">
                <div class="partner">
                    <div class="logo">
                        <div class="row">
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-PG.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-CG.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-PP.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-BG.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-VA.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-BNG.png" alt="">
                                </div>
                            </div>
                            <div class="logo-item">
                                <div class="img-crop">
                                    <img src="images/logo/logo-pagcor.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <ul class="company-info">
                    <li class="info-item ">
                        <a onclick="window.parent.API_LoadPage('About','About.html')"><span class="language_replace">關於我們</span></a>
                    </li>
					<!-- <li class="info-item ">
                        <a onclick="location.href='https://game.ewin-soft.com/GetDownloadLink.aspx?Tag=X07TATY8';"><span class="language_replace">下載代理工具</span></a>
                    </li> -->
                    <!--li class="info-item">
                        <a onclick="window.parent.API_ShowContactUs()"><span class="language_replace">聯絡客服</span></a>
                    </li>
                    <li class="info-item ">
                        <a onclick="window.parent.API_ShowPartialHtml('', 'Rules', true, null)"><span class="language_replace">利用規約</span></a>
                    </li>
                    <li class="info-item ">
                        <a onclick="window.parent.API_ShowPartialHtml('', 'PrivacyPolicy', true, null)"><span class="language_replace">隱私權政策</span></a>
                    </li>
                    <li class="info-item ">
                        <a onclick="window.parent.API_OpenHotArticle()"><span class="language_replace">熱門文章</span></a>
                    </li-->


                </ul>
                <div class="company-address">
                    <p class="name">The Orange Crest Limited</p>
                    <p class="address">Sino Centre, 582-592 Nathan Rd., Mongkok, Kowloon, Hong Kong.</p>
                </div>
                <div class="footer-copyright">
                    <p>Copyright © 2022 paradise. All Rights Reserved.</p>
                </div>
            </div>
        </footer>
    </div>
    <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="nonClose_alertContact" aria-hidden="true" id="nonClose_alertContact">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><%--<i class="icon-close-small is-hide"></i>--%></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <i class="icon-error_outline primary"></i>
                        <div class="text-wrap">
                            <p class="alertContact_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertContact_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                        <button type="button" class="alertContact_Close btn btn-outline-primary btn-sm" data-dismiss="modal"><span class="language_replace">取消</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <!-- Modal Search 品牌-LOGO版-->
    <div class="modal fade no-footer alertSearchTemp" id="alertSearch" tabindex="-1" style="display: ;"
        aria-modal="true" role="dialog">
        <div class="modal-dialog modal-xl modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-header-container">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="alertSearchCloseButton" onclick="SearchControll.closeFullSearch(this)">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="searchFilter-wrapper">
                        <div class="modal-header-container">
                            <div class="searchFilter-item input-group game-brand">
                                <div class="input-fake-select">
                                    <div class="gameName">
                                        <span class="language_replace" langkey="遊戲品牌">遊戲品牌</span>
                                        (<span class="brandSeleCount language_replace" langkey="全部">全部 </span>)
                                    </div>
                                    <div class="has-arrow"><i class="arrow"></i></div>
                                </div>
                            </div>
                            <div class="searchFilter-item input-group game-type" id="div_SearchGameCategory">
                                <select class="custom-select" id="seleGameCategory">
                                    <option class="language_replace" value="All">全部</option>
                                    <option class="language_replace" value="Electron">Electron</option>
                                    <option class="language_replace" value="Fish">Fish</option>
                                    <option class="language_replace" value="Live">Live</option>
                                    <option class="language_replace" value="Slot">Slot</option>
                                    <option class="language_replace" value="Sports">Sports</option>
                                </select>
                            </div>
                            <div class="searchFilter-item input-group keyword">
                                <!-- <input id="alertSearchKeyWord" type="text" class="form-control"
                                    language_replace="placeholder" placeholder="キーワード" enterkeyhint="" >
                                <label for="" class="form-label"><span class="language_replace">キーワード</span></label> -->
                                <label class="form-title language_replace">キーワード</label>
                                <div class="input-group">
                                    <input id="alertSearchKeyWord" type="text" class="form-control" language_replace="placeholder" placeholder="キーワード" enterkeyhint="">
                                </div>
                            </div>
                            <div class="wrapper_center action-outter">
                                <button type="button" class="btn btn btn-outline-main btn-sm btn-reset-popup"
                                    onclick="SearchControll.searchGameChangeClear()">
                                    <span class="language_replace">重新設定</span>
                                </button>
                                <button onclick="SearchControll.searchGameList()" type="button"
                                    class="btn btn-full-main btn-sm btn-search-popup btn-primary">
                                    <span class="language_replace">検索</span>
                                </button>
                            </div>
                        </div>

                        <!-- 品牌LOGO版 Collapse -->
                        <div class="brand-wrapper" style="display: none;">
                            <div class="modal-header-container">
                                <div class="brand-inner">
                                    <ul class="brand-popup-list" id="ulSearchGameBrand">
                                       
                                    </ul>
                                    <div class="wrapper_center">
                                        <button class="btn btn-primary btn-brand-confirm" type="button"
                                            onclick="SearchControll.searchGameChangeConfirm()">
                                            <span class="language_replace">確認</span>
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mask-header"></div>
                <div class="modal-body">
                    <div class="game-search-wrapper">
                        <div class="search-result-wrapper">
                            <div class="search-result-inner">
                                <div class="search-result-list">
                                    <div class="game-item-group list-row row" id="alertSearchContent">
                                    </div>
                                   <%-- <div class="s-btn-more language_replace" onclick="SearchControll.rem()">查看更多</div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 品牌LOGO版 Collapse TEST-->
    <script>
        $('.brand-wrapper:not(.show)').hide();
        $('.input-fake-select').click(function () {
            $(this).toggleClass('show');
            $(this).parents('.searchFilter-wrapper').find('.brand-wrapper').slideToggle();
            $('.mask-header').toggleClass('show');
        });
    </script>

     <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertContact" aria-hidden="true" id="alertContact">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><%--<i class="icon-close-small is-hide"></i>--%></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <i class="icon-error_outline primary"></i>
                        <div class="text-wrap">
                            <p class="alertContact_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertContact_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                        <button type="button" class="alertContact_Close btn btn-outline-primary btn-sm" data-dismiss="modal"><span class="language_replace">取消</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertPartialHtml" aria-hidden="true" id="alertPartialHtml">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title alertPartialHtml_Title">
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content alertPartialHtml_Content">
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertPartialHtml_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--alert-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertContactUs" aria-hidden="true" id="alertContactUs">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header border-bottom align-items-center">
                    <i class="icon-service"></i>
                    <h5 class="modal-title language_replace ml-1">客服信箱</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <!-- <div class="service-contact">
                            <span class="titel language_replace">客服信箱</span><span class="data"> : service@BBC117.com</span>
                        </div> -->
                        <div class="inbox_customerService" id="sendMail">
                            <div class="form-group">
                                <label class="form-title language_replace">問題分類</label>
                                <select class="form-control custom-style contectUs_Subject">
                                    <option class="language_replace">出入金</option>
                                    <option class="language_replace">註冊</option>
                                    <option class="language_replace">獎勵</option>
                                    <option class="language_replace">遊戲</option>
                                    <option class="language_replace">其他</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">信箱</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_Eamil" language_replace="placeholder" placeholder="請輸入回覆信箱" autocomplete="off">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">暱稱</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_NickName" autocomplete="off" name="NickName">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">電話</label>
                                <div class="input-group">
                                    <input type="text" class="form-control custom-style contectUs_Phone" autocomplete="off" name="Phone">
                                    <div class="invalid-feedback language_replace">錯誤提示</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">問題敘述</label>
                                <textarea class="form-control custom-style contectUs_Body" rows="5" language_replace="placeholder" placeholder=""></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-center">
                    <!-- <button class="btn btn-icon">
                        <i class="icon-copy" onclick="copyText('service@BBC117.com')"></i>
                    </button> -->
                    <div class="btn-container">
                        <button type="button" class="alertContact_OK btn btn-primary btn-block" data-dismiss="modal" onclick="sendContactUs();"><span class="language_replace">寄出</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 遊戲介紹 Modal-->
    <div class="modal fade modal-game" tabindex="-1" role="dialog" aria-labelledby="alertGameIntro" aria-hidden="true" id="alertGameIntro">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title gameRealName language_replace"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <div class="game-intro-box">
                            <div class="game-img">
                                <div class="img-wrap">
                                    <img class="GameImg" src="" alt="">
                                </div>
                            </div>
                            <div class="game-info">
                                <div class="game-detail">
                                    <div class="info-item game-num">
                                        <div class="num title">NO.</div>
                                        <div class="data GameID">01234</div>
                                    </div>
                                    <div class="info-item game-rtp">
                                        <div class="rtp-name title">RTP</div>
                                        <div class="rtp-data RtpContent"></div>
                                    </div>
                                    <!-- 當加入最愛時=> class 加 "add" -->
                                    <div class="info-item game-myFavorite add">
                                        <div class="myFavorite-name title">
                                            <span class="language_replace FavoText">加入我的最愛</span>
                                            <!-- <span class="language_replace">移除最愛</span> -->
                                        </div>
                                        <div class="myFavorite-icon">
                                            <i class="icon-casinoworld-favorite"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="game-play">
                                    <%--<button type="button" class="btn-game game-demo">
                                        <span class="language_replace">試玩</span>
                                        <div class="triangle"></div>
                                    </button>--%>
                                    <button type="button" class="btn-primary btn-game game-login">
                                        <span class="language_replace">登入玩遊戲</span>
                                    </button>
                                </div>
                            </div>
                            <div class="game-intro is-hide">
                                遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                            </div>
                        </div>

                    </div>
                </div>
                <!-- <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal"><span>前往客服</span></button>
                        <button type="button" class="btn btn-outline-primary btn-sm" data-dismiss="modal"><span>取消</span></button>
                    </div>
                </div> -->
            </div>
        </div>
    </div>

    <div id="tmpSearchGameBrand" style="display: none">
        <li class="brand-item custom-control custom-checkboxValue-noCheck">
            <label class="custom-label">
                <input type="checkbox" name="button-brandExchange" id="" class="custom-control-input-hidden searchGameBrandcheckbox" onchange="SearchControll.searchGameChange()">
                <div class="custom-input checkbox">
                    <span class="logo-wrap">
                        <span class="img-wrap">
                            <img class="brandImg" src="images/logo/default/logo-eWIN.svg" alt=""></span>
                    </span>
                </div>
            </label>
        </li>
    </div> 

    <div id="tmpSearchGameItem" class="is-hide">
        <div class="game-item col-auto">
            <div class="game-item-inner">
                <div class="game-item-img">
                    <span class="game-item-link"></span>
                    <div class="img-wrap">
                        <img class="gameimg" src="">
                    </div>
                </div>
                <div class="game-item-info">
                    <div class="game-item-info-inner">
                        <div class="game-item-info-brief">
                            <div class="game-item-info-pre">
                                <h3 class="gameName"></h3>
                            </div>
                            <div class="game-item-info-moreInfo">
                                <ul class="moreInfo-item-wrapper">
                                    <li class="moreInfo-item brand">
                                        <h4 class="value BrandName"></h4>
                                    </li>
                                    <li class="moreInfo-item category">
                                        <h4 class="value GameCategoryCode"></h4>
                                    </li>
                                    <li class="moreInfo-item RTP">
                                        <span class="title">RTP</span>
                                        <span class="value number valueRTP"></span>
                                    </li>
                                    <li class="moreInfo-item">
                                        <span class="title">NO</span>
                                        <span class="value number valueID"></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="game-item-info-indicator">
                            <div class="action">
                                <div class="btn-s-wrapper">
                                    <button type="button" class="btn-like btn btn-round">
                                          <i class="icon icon-casinoworld-heart-o"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

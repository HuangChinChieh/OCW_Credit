<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
    string Category = "";

       if (string.IsNullOrEmpty(Request["Category"]) == false)
        Category = Request["Category"];
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="Scripts/OutSrc/lib/swiper/css/swiper-bundle.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/games.css" type="text/css" />

</head>
<script type="text/javascript" src="/Scripts/Common.js?<%:Version%>"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="Scripts/OutSrc/lib/swiper/js/swiper-bundle.min.js"></script>
<%--<script src="Scripts/OutSrc/js/games.js"></script>--%>


<script type="text/javascript">      
    if (self != top) {
        window.parent.API_LoadingStart();
    }

    var ui = new uiControl();
    var c = new common();
    var mlp;
    var sumask;
    var Webinfo;
    var p;
    var nowCateg = "<%=Category%>";
    var nowSubCateg = "Hot";
    var LobbyGameList = { CategoryList: [], GameList: [], NewList: [], HotList:[]};
    var lang;
    var nowGameBrand = "All";
    var gameBrandList = [];
    var v = "<%:Version%>";
    function loginRecover() {
        window.location.href = "LoginRecover.aspx";
    }

    function selGameCategory(categoryCode) {
        var idGameItemTitle = document.getElementById("idGameItemTitle");
    
        nowCateg = categoryCode;

        idGameItemTitle.querySelectorAll(".tab-item").forEach(GI => {
            GI.classList.remove("actived");

            if (GI.classList.contains("tab_" + nowCateg)) {
                GI.classList.add("actived");
                document.getElementById("idHeadText").innerText = mlp.getLanguageKey(nowCateg);
            }
        });

        showGame(nowCateg);
    }

    function changeGameBrand() {
        showGame(nowCateg);
    }

    function showGame(categoryCode) {
        var idGameItemGroup = document.getElementById("idGameItemGroup");
        idGameItemGroup.innerHTML = "";
        GCB.GetGameCodeClassic(categoryCode, (gameItem) => {
            var gameName = gameItem.Language.find(x => x.LanguageCode == WebInfo.Lang) ? gameItem.Language.find(x => x.LanguageCode == WebInfo.Lang).DisplayText : "";
            var GI = c.getTemplate("idTemGameItem");
            var GI_img = GI.querySelector("img");
            var GI_a = GI.querySelector(".OpenGame");

            if (GI_img != null) {
                GI_img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + gameItem.GameBrand + "/PC/" + WebInfo.Lang + "/" + gameItem.GameName + ".png";
                GI_img.onerror = new Function("setDefaultIcon('" + gameItem.GameBrand + "', '" + gameItem.GameName + "')");
            }


            c.setClassText(GI, "GameCode", null, gameName);
            c.setClassText(GI, "GameID", null, c.padLeft(gameItem.GameID.toString(), 5));
            GI_a.onclick = new Function("window.parent.API_OpenGameCode('" + gameItem.GameBrand + "', '" + gameItem.GameName + "')");

            idGameItemGroup.appendChild(GI);

        }, () => {
            var idNoGameExist = document.getElementById("idNoGameExist");
            if ($('#idGameItemGroup').children().length == 0) {
                idNoGameExist.classList.remove("is-hide");
            } else {
                idNoGameExist.classList.add("is-hide");
            }
        });
        var doc = document.getElementById("searchGameByCategory");
        doc.onclick = new Function("window.parent.API_SearchGameByGameCategory('" + categoryCode + "')");
    }

    function updateGameCode() {
        var idGameItemTitle = document.getElementById("idGameItemTitle");
        //var idSecContent = document.getElementById("idSecContent");

        var idGameItemGroup = document.getElementById("idGameItemGroup");
       


        idGameItemTitle.innerHTML = "";
        idGameItemGroup.innerHTML = "";
    
        // ????????????
        var CategoryList = [];
        GCB.GetGameCategoryCode((categoryCodeItem) => {
            var BrandCateg = categoryCodeItem.GameCategoryCode;
      
            if (!CategoryList.includes(BrandCateg)) {
                CategoryList.push(BrandCateg);
                var li = document.createElement("li");
                var li_a = document.createElement("a");
                var li_a_span = document.createElement("span");
                var li_a_i = createITag(BrandCateg);
                //??????????????????????????????
                //var secGameCateg = document.createElement("section");


                //??????tab

                li_a.appendChild(li_a_i);
                li_a.appendChild(li_a_span);
                li.appendChild(li_a);
                li.classList.add("tab-item");
                li.classList.add("tab_" + BrandCateg);
                li_a.classList.add("tab-item-link");
                li_a_span.innerText = mlp.getLanguageKey(BrandCateg);

                li_a.onclick = new Function("selGameCategory('" + BrandCateg + "')");
                idGameItemTitle.appendChild(li);
            }
          
        }, () => {
            selGameCategory(nowCateg);
        })
    }

    function init() {
        if (self == top) {
            window.location.href = "index.aspx";
        }

        GCB = window.parent.API_GetGCB();
        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();

        //createGameListData();

        if (WebInfo.IsOpenGame) {
            WebInfo.IsOpenGame = false;
            window.parent.SwitchGameHeader(0);
        }

        if (nowCateg == undefined || nowCateg == "") {
            nowCateg = "Electron";
        }

   
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            GCB.InitPromise.then(() => {
            window.parent.API_LoadingEnd();
            });
      
            if ((WebInfo.SID != null)) {
                updateGameCode();
                //selGameCategory(nowCateg, nowSubCateg);
            } else {
                loginRecover();
            }
        });
    }

    function setDefaultIcon(brand, name) {
        var img = event.currentTarget;
        img.onerror = null;
        img.src = WebInfo.EWinGameUrl + "/Files/GamePlatformPic/" + brand + "/PC/" + WebInfo.Lang + "/" + name + ".png";
    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":
                //updateBaseInfo();

                break;
            case "BalanceChange":
                break;
            case "SetLanguage":
                lang = param;

                mlp.loadLanguage(lang, function () {
                    updateGameCode();
                    selGameCategory(nowCateg);
                });
                break;
        }
    }

    function createITag(Category) {
        var iTag = document.createElement("i");
        var iTagCls = "";

        switch (Category) {
            case "All":
                iTagCls = "icon-casinoworld-menu";
                break;
            case "Baccarat":
                iTagCls = "icon-casino";
                break;
            case "Live":
                iTagCls = "icon-casino";
                break;
            case "Sports":
                iTagCls = "icon-casinoworld-football";
                break;
            case "Classic":
                iTagCls = "icon-poker";
                break;
            case "Electron":
                iTagCls = "icon-casinoworld-poker";
                break;
            case "Slot":
                iTagCls = "icon-slot";
                break;
            case "Fish":
                iTagCls = "icon-casinoworld-fish-1";
                break;
            case "Finance":
                iTagCls = "icon-casinoworld-linear-chart-2";
                break;
            default:
                iTagCls = "icon-casinoworld-game-default";
                break;
        }

        iTag.classList.add(iTagCls);

        return iTag;
    }

    window.onload = init;
</script>
    
<body>
    <div class="page-container">
        <header class="heading-top-container">
            <div class="heading-top-inner">
                <h2 id="idHeadText" class="heading-top-title"></h2>
            </div>
            <img class="heading-top-img" src="images/assets/heading-img-01.jpg">
        </header>
        <div id="idSecContent" class="">

            <section class="section-wrap">
                <div class="menu-wrap menu-wrap-main">
                    <div class="menu-container">
                        <ul id="idGameItemTitle" class="tab-menu menu-main">
                        </ul>
                    </div>
                </div>
               <%-- <div class="menu-wrap menu-wrap-sub">
                    <div class="menu-container">
                        <ul id="idGameItemSubTitle" class="tab-menu menu-sub">
                            <li class="tab-item tab_Hot">
                                <a class="tab-item-link" onclick="selSubGameCategory('Hot')">
                                    <span class="language_replace">??????</span>
                                </a>
                            </li>
                            <li class="tab-item tab_New">
                                <a class="tab-item-link" onclick="selSubGameCategory('New')">
                                    <span class="language_replace">??????</span>
                                </a>
                            </li>
                        </ul>
                        <div class="menu-filter brand" style="display: none;">
                            <select id="idGameBrandSel" onchange="changeGameBrand();" class="form-control custom-style">
                                <option value="All">All</option>
                            </select>
                        </div>
                    </div>

                </div>--%>
            </section>

            <!-- ???????????? -->
            <section class="section-wrap game-list">
                <div class="page-content">
                    <div id="idGameItemGroup" class="game-item-group">
                    </div>
                    <!-- <button type="button" class="btn btn btn-outline-main btn-sm btn-reset-popup" onclick="">
                        <span class="language_replace">???????????????</span>
                    </button> -->
                    <div class="wrapper_center wrapper-btnmore">
                        <button class="btn btn btn-outline-main" type="button" id="searchGameByCategory"><span class="language_replace">????????????</span>
                        </button>
                    </div>
                    <div id="idNoGameExist" class="is-hide">
                        <span class="language_replace">???????????????????????????????????????????????????</span>
                    </div>
                </div>
            </section>


        </div>
        <div id="idTemGameItem" class="is-hide">
            <div class="game-item">
                <a class="game-item-link"></a>
                <div class="img-wrap">
                    <img src="">
                </div>
                <div class="game-item-info">
                    <h3 class="game-item-name GameCode"></h3>
                    <button type="button" class="btn btn-primary game-item-btn OpenGame"><span class="language_replace">GO</span></button>
                    <div class="game-item-name" style="text-align: right; position: absolute; bottom: 10px; right: 5px; font-size: 12px;">
                        No:<span class="GameID"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

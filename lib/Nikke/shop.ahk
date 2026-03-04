#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\3rd\FindText.ahk"
#Include "..\3rd\PicLib.ahk"
#Include "..\helper.ahk"
global nikkePosH, nikkePosW, nikkePosX, nikkePosY, zoomH, zoomW, PicTolerance, nikkeServer

class shop extends baseFunc{
;======================================================================
    ;tag 通用商店购买处理逻辑
    static ProcessPurchaseList(PurchaseItems, Options := Map()) {
        ; Options 参数支持: "CheckCredit" (检查信用点), "CheckMax" (检查MAX按钮)
        ; 新增支持: "Area" (自定义识图区域，格式为数组 [x1, y1, x2, y2])
        ; 默认区域
        sX1 := nikkePosX + 0.049 * nikkePosW
        sY1 := nikkePosY + 0.479 * nikkePosH
        sX2 := nikkePosX + 0.989 * nikkePosW
        sY2 := nikkePosY + 0.918 * nikkePosH
        ; 解析 Area 参数 (如果存在且为数组)
        if Options.Has("Area") and IsObject(Options["Area"]) and Options["Area"].Length >= 4 {
            sX1 := Options["Area"][1]
            sY1 := Options["Area"][2]
            sX2 := Options["Area"][3]
            sY2 := Options["Area"][4]
        }
        for Name, item in PurchaseItems {
            if (!item.Setting) {
                continue ; 如果设置未开启，则跳过此物品
            }
            ; 查找物品 (使用动态坐标 sX1, sY1, sX2, sY2)
            if (ok := FindText(&X := "wait", &Y := 1, sX1, sY1, sX2, sY2, item.Tolerance, item.Tolerance, item.Text, , , , , , 1, zoomW / item.zoomScale, zoomH / item.zoomScale)) {
                ; 遍历找到的所有物品 (例如多个手册)
                loop ok.Length {
                    FindText().Click(ok[A_Index].x, ok[A_Index].y, "L")
                    ;AddLog("已找到" . Name)
                    Sleep 1000
                    ; 特殊逻辑：普通商店芯尘盒需要检查是否为信用点购买
                    if (Options.Has("CheckCredit") && Name = "芯尘盒") {
                        if (!FindText(&X := "wait", &Y := 2, nikkePosX + 0.430 * nikkePosW . " ", nikkePosY + 0.716 * nikkePosH . " ", nikkePosX + 0.430 * nikkePosW + 0.139 * nikkePosW . " ", nikkePosY + 0.716 * nikkePosH + 0.034 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("信用点的图标"), , 0, , , , , zoomW / item.zoomScale, zoomH / item.zoomScale)) {
                            ;AddLog("未检测到信用点支付选项，跳过")
                            idleClick()
                            Sleep 1000
                            continue
                        }
                    }
                    ; 特殊逻辑：废铁商店需要点击MAX
                    if (Options.Has("CheckMax")) {
                        if (FindText(&X := "wait", &Y := 2, nikkePosX + 0.590 * nikkePosW . " ", nikkePosY + 0.595 * nikkePosH . " ", nikkePosX + 0.590 * nikkePosW + 0.038 * nikkePosW . " ", nikkePosY + 0.595 * nikkePosH + 0.070 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("MAX"), , 0, , , , , zoomW / item.zoomScale, zoomH / item.zoomScale)) {
                            FindText().Click(X, Y, "L")
                            Sleep 1000
                        }
                    }
                    ; 点击购买 (带圈白勾)
                    if (FindText(&X := "wait", &Y := 2, nikkePosX + 0.506 * nikkePosW . " ", nikkePosY + 0.786 * nikkePosH . " ", nikkePosX + 0.506 * nikkePosW + 0.088 * nikkePosW . " ", nikkePosY + 0.786 * nikkePosH + 0.146 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW / item.zoomScale, zoomH / item.zoomScale)) {
                        Sleep 500
                        ;AddLog("购买" . Name)
                        FindText().Click(X, Y, "L")
                        Sleep 1000
                        ; 确认并返回商店主界面 (检查左上角百货商店图标)
                        while !(FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("左上角的百货商店"), , 0, , , , , zoomW / item.zoomScale, zoomH / item.zoomScale)) {
                            idleClick()
                        }
                    }
                }
            } else {
                ;AddLog(Name . "未找到，跳过购买")
            }
        }
    }

    ;tag 进入商店
    static toGeneralShop() {
        while (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.236 * nikkePosW . " ", nikkePosY + 0.633 * nikkePosH . " ", nikkePosX + 0.236 * nikkePosW + 0.118 * nikkePosW . " ", nikkePosY + 0.633 * nikkePosH + 0.103 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("商店的图标"), , , , , , , zoomW, zoomH)) {
            ;AddLog("点击商店图标")
            FindText().Click(X + 20 * zoomH, Y - 20 * zoomH, "L")
        }
        else {
            MsgBox("商店图标未找到")
        }
        if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("左上角的百货商店"), , , , , , , zoomW, zoomH)) {
            ;AddLog("已进入百货商店")
        }
    }

    ;tag 普通商店
    static ShopGeneral() {
        shop.toGeneralShop()
        ;AddLog("开始任务：普通商店", "Fuchsia")
        Sleep 1000
        ; 定义物品
        PurchaseItems := Map(
            "免费商品", { Text: FindText().PicLib("红点"), Setting: 1, Tolerance: 0.15 * 1 , zoomScale : 1},
            "芯尘盒", { Text: FindText().PicLib("芯尘盒"), Setting: 1, Tolerance: 0.2 * 1 , zoomScale : 1}
        )
        ; 定义普通商店的识图区域 (将坐标放入数组中)
        GeneralShopArea := Map(
            "CheckCredit", true,
            "Area", [nikkePosX + 0.055 * nikkePosW . " ", nikkePosY + 0.481 * nikkePosH . " ", nikkePosX + 0.055 * nikkePosW + 0.426 * nikkePosW . " ", nikkePosY + 0.481 * nikkePosH + 0.237 * nikkePosH . " "]
        )
        loop 2 {
            ; 调用通用处理函数，传入区域配置
            shop.ProcessPurchaseList(PurchaseItems, GeneralShopArea)
            ; 刷新逻辑保持不变
            while (ok := FindText(&X, &Y, nikkePosX + 0.173 * nikkePosW . " ", nikkePosY + 0.423 * nikkePosH . " ", nikkePosX + 0.173 * nikkePosW + 0.034 * nikkePosW . " ", nikkePosY + 0.423 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("FREE"), , , , , , , zoomW, zoomH)) {
                ;AddLog("尝试刷新商店")
                FindText().Click(X - 100 * zoomH, Y + 30 * zoomH, "L")
                Sleep 500
                if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.504 * nikkePosW . " ", nikkePosY + 0.593 * nikkePosH . " ", nikkePosX + 0.504 * nikkePosW + 0.127 * nikkePosW . " ", nikkePosY + 0.593 * nikkePosH + 0.066 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
                    FindText().Click(X, Y, "L")
                    Sleep 500
                    ;AddLog("刷新成功")
                }
            } else {
                ;AddLog("没有免费刷新次数了，跳过刷新")
                break
            }
            Sleep 2000
        }
        shop.ShopArena
    }

    ;tag 竞技场商店
    static ShopArena() {
        ;AddLog("开始任务：竞技场商店", "Fuchsia")
        if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.001 * nikkePosW . " ", nikkePosY + 0.355 * nikkePosH . " ", nikkePosX + 0.001 * nikkePosW + 0.041 * nikkePosW . " ", nikkePosY + 0.355 * nikkePosH + 0.555 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("竞技场商店的图标"), , , , , , , zoomW, zoomH)) {
            ;AddLog("进入竞技场商店")
            FindText().Click(X, Y, "L")
            Sleep 1000
        } else {
            ;AddLog("竞技场商店图标未找到", "Red")
            return
        }
        PurchaseItems := Map(
            ;"燃烧代码手册", { Text: FindText().PicLib("燃烧代码的图标"), Setting: g_settings["ShopArenaBookFire"], Tolerance: 0.2 * PicTolerance },
            ;"水冷代码手册", { Text: FindText().PicLib("水冷代码的图标"), Setting: g_settings["ShopArenaBookWater"], Tolerance: 0.2 * PicTolerance },
            ;"风压代码手册", { Text: FindText().PicLib("风压代码的图标"), Setting: g_settings["ShopArenaBookWind"], Tolerance: 0.3 * PicTolerance },
            ;"电击代码手册", { Text: FindText().PicLib("电击代码的图标"), Setting: g_settings["ShopArenaBookElec"], Tolerance: 0.2 * PicTolerance },
            ;"铁甲代码手册", { Text: FindText().PicLib("铁甲代码的图标"), Setting: g_settings["ShopArenaBookIron"], Tolerance: 0.2 * PicTolerance },
            "代码手册宝箱", { Text: FindText().PicLib("代码手册选择宝箱的图标"), Setting: 1, Tolerance: 0.3 * PicTolerance, zoomScale : 1},
            ;"简介个性化礼包", { Text: FindText().PicLib("简介个性化礼包"), Setting: g_settings["ShopArenaPackage"], Tolerance: 0.3 * PicTolerance },
            "公司武器熔炉", { Text: FindText().PicLib("公司武器熔炉"), Setting: 1, Tolerance: 0.3 * PicTolerance, zoomScale : 1 }
        )
        if (!nikkeServer){ 
            PurchaseItems.Set("模组高级增强器",{ Text: FindText().PicLib("模组高级增强器"), Setting: 1, Tolerance: 0.3 * PicTolerance, zoomScale : 1.5 })
        }
        ; 定义竞技场商店的识图区域 (将坐标放入数组中)
        ArenaShopArea := Map(
            "Area", [nikkePosX + 0.054 * nikkePosW . " ", nikkePosY + 0.481 * nikkePosH . " ", nikkePosX + 0.054 * nikkePosW + 0.511 * nikkePosW . " ", nikkePosY + 0.481 * nikkePosH + 0.238 * nikkePosH . " "]
        )
        ; 调用通用处理函数，传入区域配置
        shop.ProcessPurchaseList(PurchaseItems, ArenaShopArea)
        backHall
    }

;======================================================================

    ;付费商店功能
    static ShopCash() {
        if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.250 * nikkePosW . " ", nikkePosY + 0.599 * nikkePosH . " ", nikkePosX + 0.250 * nikkePosW + 0.027 * nikkePosW . " ", nikkePosY + 0.599 * nikkePosH + 0.047 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("付费商店的图标"), , , , , , , zoomW, zoomH)) {
            ;;AddLog("点击付费商店")
            FindText().Click(X, Y, "L")
            Sleep 2000
            
            ;;AddLog("领取免费珠宝")
            while true {
                if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.386 * nikkePosW . " ", nikkePosY + 0.632 * nikkePosH . " ", nikkePosX + 0.386 * nikkePosW + 0.016 * nikkePosW . " ", nikkePosY + 0.632 * nikkePosH + 0.025 * nikkePosH . " ", 0.2 * 1, 0.2 * 1, FindText().PicLib("灰色空心方框"), , , , , , , zoomW, zoomH)) {
                    ;;AddLog("发现日服特供的框")
                    FindText().Click(X, Y, "L")
                    Sleep 1000
                    if (ok := FindText(&X := "wait", &Y := 3, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.3 * 1, 0.3 * 1, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW, zoomH)) {
                        ;;AddLog("点击确认")
                        FindText().Click(X, Y, "L")
                    }
                }
                else if (ok := FindText(&X, &Y, nikkePosX + 0.040 * nikkePosW . " ", nikkePosY + 0.178 * nikkePosH . " ", nikkePosX + 0.040 * nikkePosW + 0.229 * nikkePosW . " ", nikkePosY + 0.178 * nikkePosH + 0.080 * nikkePosH . " ", 0.2 * 1, 0.2 * 1, FindText().PicLib("礼物的下半"), , , , , , , zoomW, zoomH)) {
                    Sleep 500
                    ;;AddLog("点击一级页面")
                    FindText().Click(X + 20 * zoomW, Y + 20 * zoomH, "L")
                    Sleep 500
                }
                else break
            }
            while (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.002 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH . " ", nikkePosX + 0.002 * nikkePosW + 0.367 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH + 0.062 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , 1, zoomW, zoomH)) {
                ;;AddLog("点击二级页面")
                FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                Sleep 1000
                if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.002 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH . " ", nikkePosX + 0.002 * nikkePosW + 0.367 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH + 0.062 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , zoomW, zoomH)) {
                    ;;AddLog("移除N标签")
                    FindText().Click(X, Y, "L")
                    Sleep 1000
                    scaledClick(238, 608)
                    Sleep 1000
                }
                if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.089 * nikkePosW . " ", nikkePosY + 0.334 * nikkePosH . " ", nikkePosX + 0.089 * nikkePosW + 0.019 * nikkePosW . " ", nikkePosY + 0.334 * nikkePosH + 0.034 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("红点"), , , , , , 5, zoomW, zoomH)) {
                    ;;AddLog("点击三级页面")
                    FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                    Sleep 1000
                    idleClick
                    Sleep 500
                    idleClick
                }
                if (ok := FindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.2 * 1, 0.2 * 1, FindText().PicLib("白色的叉叉"), , , , , , , zoomW, zoomH)) {
                    FindText().Click(X, Y, "L")
                    ;;AddLog("检测到白色叉叉，尝试重新执行任务")
                    backHall
                    shop.ShopCash
                }
            }
            else {
                ;;AddLog("奖励已全部领取")
            }

            ;;AddLog("领取免费礼包")
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.180 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.266 * nikkePosW . " ", nikkePosY + 0.180 * nikkePosH + 0.077 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                ;;AddLog("点击一级页面")
                FindText().Click(X - 20 * zoomH, Y + 20 * zoomH, "L")
                Sleep 1000
                if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.010 * nikkePosW . " ", nikkePosY + 0.259 * nikkePosH . " ", nikkePosX + 0.010 * nikkePosW + 0.351 * nikkePosW . " ", nikkePosY + 0.259 * nikkePosH + 0.051 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                    ;;AddLog("点击二级页面")
                    FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                    Sleep 1000
                    ;把鼠标移动到商品栏
                    scaledClick(1918, 1060)
                    Send "{WheelUp 3}"
                    Sleep 1000
                }
                if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.332 * nikkePosW . " ", nikkePosY + 0.443 * nikkePosH . " ", nikkePosX + 0.332 * nikkePosW + 0.327 * nikkePosW . " ", nikkePosY + 0.443 * nikkePosH + 0.466 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                    ;;AddLog("点击三级页面")
                    FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                    Sleep 1000
                    idleClick
                }
            }
            ;;AddLog("奖励已全部领取")

            while (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.001 * nikkePosW . " ", nikkePosY + 0.191 * nikkePosH . " ", nikkePosX + 0.001 * nikkePosW + 0.292 * nikkePosW . " ", nikkePosY + 0.191 * nikkePosH + 0.033 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , 0.83 * zoomW, 0.83 * zoomH)) {
                FindText().Click(X, Y, "L")
                Sleep 1000
                while (ok := FindText(&X, &Y, nikkePosX + 0.005 * nikkePosW . " ", nikkePosY + 0.254 * nikkePosH . " ", nikkePosX + 0.005 * nikkePosW + 0.468 * nikkePosW . " ", nikkePosY + 0.254 * nikkePosH + 0.031 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , zoomW, zoomH)) {
                    FindText().Click(X, Y, "L")
                    Sleep 1000
                    scaledClick(208, 608)
                    Sleep 1000
                    scaledClick(62, 494)
                }
            }
        }
        backHall
    }

    init(mainGui, optStr){
        this.addCheckRow(mainGui,"付费商店免费珠宝", optStr, Shop.ShopCash)
        this.addCheckRow(mainGui,"普通商店商品(含竞技场商店)","", Shop.ShopGeneral)
    }
}
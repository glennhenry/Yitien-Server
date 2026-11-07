package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_quest_step_type;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.model.Model_quest;
   import com.yiTian.data.vo.Vo_jingJiChang;
   import com.yiTian.manager.DailyRemainManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.QuestGuiManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.mainUIBtnContainer.IMainUiBtn;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class View_jingJiChang extends Panel123
   {
      
      public static var _personelPos:int;
      
      public static var _xuanYaoTimes:int;
      
      public static var isSpeedAble:Boolean;
      
      private var Button_JFStore:Button;
      
      private var Button_JJPaiHeng:Button;
      
      private var Button_RYTiaoZhan:Button;
      
      private var Button_MyInformat:Button;
      
      public var RYPaiMing_text:MyTextField;
      
      private var PaiMing_text:MyTextField;
      
      public var Time_text:MyTextField;
      
      public var WinPecent_text:MyTextField;
      
      public var TXChiShu_text:MyTextField;
      
      private var JRZhanBao_text:MyTextField;
      
      private var LingJiang_text:MyTextField;
      
      public var itemArr:Array = [];
      
      public var Item_TZ:View_tiaozhanItem;
      
      private var back:ScaleBitmap;
      
      private var awardItem:View_awardItem;
      
      private var warInfor:WarInfor;
      
      private var totalWarArr:Array = [];
      
      private var selfWarArr:Array = [];
      
      private var vipTxt:MyTextField;
      
      private var jumpTF:MyTextField;
      
      public var jingBtn:MainUIBtn;
      
      private var tf:MyTextField;
      
      private var mskSpri:Sprite;
      
      private var contan:Sprite;
      
      private var _moveBar:Sprite;
      
      private var luckyTips:luckyNumTips = new luckyNumTips();
      
      private var luckNumText:MyTextField;
      
      private var luckyNum:int = -2;
      
      private var starClkBoo:Boolean = false;
      
      private var myDataArr:Array = [];
      
      public var _leftTime:int;
      
      private var _gapTimes:int;
      
      private var vipStrArr:Array = new Array();
      
      private var isFirstEnter:Boolean = false;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      private var snowBack:Sprite;
      
      private var warSnowMan:Button;
      
      private var loadSnowMan:Boolean;
      
      private var lastTime:int;
      
      public var statusArr:Array = new Array();
      
      private var warInfDataArr:Array = [];
      
      private var resultColorArr:Array = ["#faff00","#00cc00"];
      
      private var maskZB:Sprite;
      
      private var ZBSpr:Sprite;
      
      public var _price:int;
      
      private var curItem:View_tiaozhanItem;
      
      public function View_jingJiChang()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var j:int = 0;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":731,
            "height":442
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":683,
            "height":362
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":31,
            "y":70,
            "width":669,
            "height":325
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":128,
            "y":75,
            "width":360,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":38,
            "y":75,
            "width":85,
            "height":315
         },Global.Img_Cdm);
         this._moveBar = new Sprite();
         this._moveBar.graphics.beginFill(0,0);
         moveBar.graphics.drawRect(0,0,730,38);
         moveBar.graphics.endFill();
         this._moveBar.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
         this._moveBar.addEventListener(MouseEvent.MOUSE_UP,upEvent);
         addChild(this._moveBar);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":493,
            "y":75,
            "width":200,
            "height":315
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":130,
            "y":77,
            "width":356,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":495,
            "y":77,
            "width":196,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":495,
            "y":250,
            "width":196,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60155",6),this,{
            "x":54,
            "y":80,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60156",6),this,{
            "x":300,
            "y":46,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60157",6),this,{
            "x":140,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60004",6),this,{
            "x":300,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60158",6),this,{
            "x":238,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60001",6),this,{
            "x":362,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
            "x":424,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60159",6),this,{
            "x":570,
            "y":77,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60160",6),this,{
            "x":570,
            "y":250,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60161",6),this,{
            "x":36,
            "y":410,
            "color":16773818,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":697,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_JFStore = ComponentUtil.getButton(HtmlUtil.font(LangConfig.getWord("314",0),"#9ada78"),"Button_Four",this,{
            "x":515,
            "y":405.75
         },Global.Img_Cdm);
         this.Button_JJPaiHeng = ComponentUtil.getButton(LangConfig.getWord("60162",6),"Button_Four",this,{
            "x":620,
            "y":408,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_MyInformat = ComponentUtil.getButton(LangConfig.getWord("60163",6),"Button_Four",this,{
            "x":535,
            "y":408,
            "textColor":16184781
         },Global.Img_Cdm);
         if(GameUnitManager.hero.level >= 28)
         {
            this.show_jjc_btn();
         }
         i = 0;
         while(i < 10)
         {
            this.Item_TZ = new View_tiaozhanItem();
            this.Item_TZ.x = 130;
            this.Item_TZ.y = 97 + i * 29;
            addChild(this.Item_TZ);
            this.itemArr.push(this.Item_TZ);
            this.Item_TZ.visible = false;
            this.Item_TZ.addEventListener(MouseEvent.CLICK,this.itemOnClick);
            this.Item_TZ = null;
            i++;
         }
         j = 0;
         while(j < 4)
         {
            this.awardItem = new View_awardItem(j);
            this.awardItem.x = 46;
            this.awardItem.y = 102 + 72 * j;
            addChild(this.awardItem);
            j++;
         }
         this.contan = new Sprite();
         addChild(this.contan);
         ComponentUtil.setPropertie(this.contan,{
            "x":500,
            "y":268
         });
         this.mskSpri = new Sprite();
         this.mskSpri.graphics.beginFill(0,0.3);
         this.mskSpri.graphics.drawRect(0,0,196,120);
         this.mskSpri.graphics.endFill();
         ComponentUtil.setPropertie(this.mskSpri,{
            "x":497,
            "y":266
         });
         addChild(this.mskSpri);
         this.contan.mask = this.mskSpri;
         this.RYPaiMing_text = ComponentUtil.getTextField("1",this,{
            "x":431.8,
            "y":409.75,
            "realWidth":27,
            "realHeight":20
         });
         this.RYPaiMing_text.align = TextFormatAlign.CENTER;
         this.RYPaiMing_text.type = TextFieldType.INPUT;
         this.RYPaiMing_text.restrict = ".0-9";
         this.RYPaiMing_text.maxChars = 3;
         this.RYPaiMing_text.textColor = 14013822;
         this.RYPaiMing_text.visible = false;
         ComponentUtil.getTextField(LangConfig.getWord("60164",6),this,{
            "x":425,
            "y":410,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.PaiMing_text = ComponentUtil.getTextField("0000",this,{
            "x":490,
            "y":410,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60165",6),this,{
            "x":280,
            "y":410,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.Time_text = ComponentUtil.getTextField("00：00：00",this,{
            "x":345,
            "y":410,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.jumpTF = ComponentUtil.getTextField(LangConfig.getWord("317",0),this,{
            "x":this.Time_text.x + 40,
            "y":409.75,
            "realWidth":50
         });
         this.jumpTF.mouseEnabled = true;
         this.jumpTF.htmlText = "<u>" + HtmlUtil.link(HtmlUtil.font(LangConfig.getWord("317",0),"#66cc00"),"") + "</u>";
         this.jumpTF.addEventListener(TextEvent.LINK,this.linkHandle);
         this.WinPecent_text = ComponentUtil.getTextField("0%",this,{
            "x":539.15,
            "y":47.75
         });
         this.WinPecent_text.visible = false;
         this.TXChiShu_text = ComponentUtil.getTextField("00",this,{
            "x":115,
            "y":410,
            "color":16773818,
            "size":12,
            "leading":0
         });
         this.vipTxt = ComponentUtil.getTextField(LangConfig.getWord("318",0),this,{
            "x":this.TXChiShu_text.x + 25,
            "y":409.75,
            "textColor":16711680
         });
         this.Button_MyInformat.addEventListener(MouseEvent.CLICK,this.selfInfoHandle);
         this.Button_MyInformat.addEventListener(MouseEvent.MOUSE_DOWN,this.mHandle);
         this.Button_MyInformat.visible = false;
         this.Button_JJPaiHeng.addEventListener(MouseEvent.CLICK,this.paiHangHandle);
         this.Button_JFStore.visible = false;
         if(GameUnitManager.hero.level >= 25)
         {
            JingJiChangCGMessage.CG_GET_PAIMING();
         }
      }
      
      private function initluckyNum() : void
      {
         var starBtn:Button = ComponentUtil.getButton("","Button_XingXing",this,{
            "x":38,
            "y":43,
            "textColor":16771436
         },Global.XXPPdm);
         starBtn.addEventListener(MouseEvent.CLICK,this.starSprClkHandle);
         ComponentUtil.getTextField(LangConfig.getWord("30137",3),this,{
            "x":68,
            "y":45,
            "color":3394815,
            "size":14,
            "leading":0
         });
         this.luckNumText = ComponentUtil.getTextField("?",this,{
            "x":140,
            "y":38,
            "color":16383744,
            "size":26,
            "leading":0
         });
         if(this.luckyNum != -2)
         {
            this.updateLuckNum(this.luckyNum);
         }
      }
      
      public function updateLuckNum(num:int) : void
      {
         this.luckyNum = num;
         if(!this.luckNumText)
         {
            return;
         }
         if(num >= 0 && num <= 9)
         {
            this.luckNumText.text = num.toString();
         }
         if(num == -1)
         {
            this.luckNumText.text = "?";
         }
         this.showLuckyStar(num);
      }
      
      private function showLuckyStar(num:int) : void
      {
         var i:int = 0;
         while(i < 10)
         {
            View_tiaozhanItem(this.itemArr[i]).showLuckyStar(num);
            i++;
         }
      }
      
      private function starSprClkHandle(evt:MouseEvent = null) : void
      {
         if(this.isFirstEnter)
         {
            if(evt == null && this.luckyTips.showTips)
            {
               return;
            }
         }
         if(!this.isFirstEnter)
         {
            this.isFirstEnter = true;
         }
         if(evt != null)
         {
            this.starClkBoo = true;
         }
         if(!this.contains(this.luckyTips))
         {
            this.addChild(this.luckyTips);
         }
         this.luckyTips.x = (this.back.width - luckyNumTips.Wid) / 2;
         this.luckyTips.y = (this.back.height - luckyNumTips.Hei) / 2;
         this.addEventListener(MouseEvent.CLICK,this.luckyClkHandle);
         this.luckyTips.visible = true;
         this.luckyTips.alpha = 1;
         this.luckyTips.scaleX = 1;
         this.luckyTips.scaleY = 1;
      }
      
      private function linkHandle(e:TextEvent) : void
      {
         if(this._leftTime == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("319",0));
            return;
         }
         View_Alert.show(LangConfig.getWord("176",0) + String(Math.ceil(this._leftTime / 60)) + LangConfig.getWord("320",0),View_Alert.OK_CANCAL,this.okHandle);
      }
      
      private function jingClick(e:MouseEvent = null) : void
      {
         if(GameUnitManager.hero.level < 25)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10506",1,25));
            return;
         }
         this.visible = !visible;
      }
      
      public function show_jjc_btn() : IMainUiBtn
      {
         if(!this.jingBtn)
         {
            this.jingBtn = new MainUIBtn("resource/image/jjc/JJZ_icon.png",null,null,null,true);
            this.jingBtn.addEventListener(MouseEvent.CLICK,this.jingClick);
         }
         if(!this.tf)
         {
            this.tf = ComponentUtil.getTextField("",this.jingBtn,{
               "x":6,
               "y":52,
               "color":16383744,
               "bold":true,
               "realWidth":54
            });
            this.tf.autoSize = TextFieldAutoSize.CENTER;
         }
         if(!UIManager.mainUiBtnContainer.hasBTN(this.jingBtn))
         {
            UIManager.mainUiBtnContainer.addBTN(this.jingBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JingJiChang,1]);
         return this.jingBtn;
      }
      
      public function set_jjc_count(count:int) : void
      {
         if(Boolean(this.jingBtn))
         {
            this.jingBtn.showTime(count);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.SET_COUNT,[Enum_mainUIBtn_hide.JingJiChang,count]);
      }
      
      public function remove_jjc_btn() : void
      {
         if(UIManager.mainUiBtnContainer.hasBTN(this.jingBtn))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.jingBtn);
         }
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JingJiChang,2]);
      }
      
      private function okHandle(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < Math.ceil(this._leftTime / 60))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("321",0));
            return;
         }
         JingJiChangCGMessage.CG_SPEED();
      }
      
      private function getTim(param_num:int) : String
      {
         var temNum:int = int(param_num / 3600);
         if(temNum < 1)
         {
            return HtmlUtil.font(LangConfig.getWord("322",0),"#ffff00");
         }
         return HtmlUtil.font(String(temNum) + LangConfig.getWord("323",0),"#ffff00");
      }
      
      public function getStr(_roleId:int, roleName:String, _job:int) : String
      {
         return "<a href=\'event:" + _roleId + "\'>" + HtmlUtil.underLine(HtmlUtil.font(roleName,Model_jingJiChang.get_color[_job - 1])) + "</a>";
      }
      
      public function upMyWarInfor(arr:Array) : void
      {
         var warItem:WarInfor = null;
         var _vo:Vo_jjc = null;
         var timeStr:String = null;
         this.resetWarInfo(this.myDataArr);
         if(!arr.length)
         {
            return;
         }
         if(arr.length > 3)
         {
            arr.length = 3;
         }
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            warItem = WarInfor.instance;
            _vo = arr[i];
            warItem.warId = _vo.war_id;
            timeStr = this.getTim(_vo.time);
            if(_vo.result == 0)
            {
               if(_vo.zhuDong_id == GameUnitManager.hero.id)
               {
                  if(_vo.changed == 0)
                  {
                     warItem.updata(timeStr + LangConfig.getWord("324",0) + LangConfig.getWord("325",0) + this.getStr(_vo.beiDong_id,_vo.b_name,_vo.b_job) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc")) + "。";
                  }
                  else
                  {
                     warItem.updata(timeStr + LangConfig.getWord("324",0) + LangConfig.getWord("325",0) + this.getStr(_vo.beiDong_id,_vo.b_name,_vo.b_job) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc")) + "。";
                  }
               }
               else if(_vo.changed == 0)
               {
                  warItem.updata(timeStr + this.getStr(_vo.zhuDong_id,_vo.z_name,_vo.z_job) + LangConfig.getWord("325",0) + LangConfig.getWord("324",0) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc")) + "。";
               }
               else
               {
                  warItem.updata(timeStr + this.getStr(_vo.zhuDong_id,_vo.z_name,_vo.z_job) + LangConfig.getWord("325",0) + LangConfig.getWord("324",0) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc")) + "。";
               }
            }
            else if(_vo.zhuDong_id == GameUnitManager.hero.id)
            {
               if(_vo.changed == 0)
               {
                  warItem.updata(timeStr + LangConfig.getWord("324",0) + LangConfig.getWord("325",0) + this.getStr(_vo.beiDong_id,_vo.b_name,_vo.b_job) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc") + "。" + "<a href=\'event:" + _vo.war_id.toString() + "\'>" + "<u>" + HtmlUtil.font("炫耀","#fe0000") + "</u>" + "</a>");
               }
               else
               {
                  warItem.updata(timeStr + LangConfig.getWord("324",0) + LangConfig.getWord("325",0) + this.getStr(_vo.beiDong_id,_vo.b_name,_vo.b_job) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("327",0),"#33cc99") + "。" + "<a href=\'event:" + _vo.war_id.toString() + "\'>" + "<u>" + HtmlUtil.font("炫耀","#fe0000") + "</u>" + "</a>");
               }
            }
            else if(_vo.changed == 1)
            {
               warItem.updata(timeStr + this.getStr(_vo.zhuDong_id,_vo.z_name,_vo.z_job) + LangConfig.getWord("325",0) + LangConfig.getWord("467",0) + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("328",0),"#ffcc66")) + "。";
            }
            else
            {
               warItem.updata(timeStr + this.getStr(_vo.zhuDong_id,_vo.z_name,_vo.z_job) + LangConfig.getWord("325",0) + LangConfig.getWord("467",0) + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[_vo.result] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("326",0),"#3399cc")) + "。";
            }
            this.contan.addChild(warItem);
            this.myDataArr.push(warItem);
            i++;
         }
         this.rePos();
      }
      
      private function rePos() : void
      {
         var item:WarInfor = null;
         var j:int = 0;
         var i:int = 0;
         while(i < this.myDataArr.length)
         {
            item = this.myDataArr[i];
            item.x = 0;
            item.y = 0 + j;
            j += item.height + 6;
            i++;
         }
      }
      
      private function mHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function tiaoZhengHandle() : void
      {
         if(int(this.TXChiShu_text.text) < 0)
         {
            this.TXChiShu_text.text = "0";
         }
      }
      
      public function JFHandle(e:MouseEvent) : void
      {
      }
      
      public function setTime() : void
      {
         this._leftTime = 0;
         this.Time_text.textColor = 16763904;
         this.Time_text.text = "00:00";
         this.jumpTF.filters = Util.disabled;
         this.jumpTF.visible = false;
      }
      
      public function selfInfoHandle(e:MouseEvent) : void
      {
         UIManager.myInfoPanel.visible = !UIManager.myInfoPanel.visible;
         UIManager.myInfoPanel.showSelfHead();
      }
      
      public function updata(len:int, shengRate:int, canWar:int, curPosition:int, lfTime:int, xuanYaoTimes:int) : void
      {
         var temItem:View_tiaozhanItem = null;
         var temData:Vo_jingJiChang = null;
         this._leftTime = lfTime;
         Model_jingJiChang.canWar = canWar;
         _xuanYaoTimes = xuanYaoTimes;
         if(lfTime != 0)
         {
            this.Time_text.text = String(DateUtil.getMSBySecond3(this._leftTime));
         }
         if(this._leftTime == 0)
         {
            this.Time_text.textColor = 16763904;
         }
         else
         {
            this.Time_text.textColor = 16711680;
         }
         if(len > this.itemArr.length)
         {
            len = int(this.itemArr.length);
         }
         var i:int = 0;
         while(i < len)
         {
            this.itemArr[i].visible = true;
            temData = Model_jingJiChang.jjc_data[i];
            temItem = this.itemArr[i];
            temItem._zhanLi = temData.role_zhanLi;
            temItem._job = temData.job;
            temItem.TZName = temData.role_name;
            temItem.paiMing = temData.pai_ming;
            temItem.level = temData.level;
            temItem._sex = temData.sex;
            temItem._roleId = temData.roldId;
            temItem._lfTime = lfTime;
            temItem._petId = temData.pet_id;
            temItem.update_pos(temData.hero_position,temData.pet_position,temData.pet_icon);
            i++;
         }
         this.PaiMing_text.textColor = 16383744;
         _personelPos = curPosition;
         this.PaiMing_text.text = String(curPosition);
         this.TXChiShu_text.textColor = 3394815;
         this.TXChiShu_text.text = String(canWar);
         DailyRemainManager.setCount(DailyRemainManager.JJC,canWar);
         var maxT:int = 15 + this.InTimes(GameUnitManager.hero.vip);
         this.gapTimes = maxT - canWar;
         this.WinPecent_text.textColor = 16755712;
         this.WinPecent_text.text = String(shengRate + "%");
         GameScene.instance.addFrameCallBack(this.timeMinus);
         this.tiaoZhengHandle();
      }
      
      private function InTimes(_value:int) : int
      {
         switch(_value)
         {
            case 0:
               return 0;
            case 1:
               return 2;
            case 2:
               return 3;
            case 3:
               return 5;
            default:
               return 0;
         }
      }
      
      public function set gapTimes(value:int) : void
      {
         this._gapTimes = value;
      }
      
      public function get gapTimes() : int
      {
         return this._gapTimes;
      }
      
      private function setStrArr() : void
      {
         this.vipStrArr = [LangConfig.getWord("318",0),LangConfig.getWord("329",0),LangConfig.getWord("330",0),LangConfig.getWord("331",0)];
         this.statusArr = [LangConfig.getWord("332",0),LangConfig.getWord("333",0)];
      }
      
      private function luckyClkHandle(evt:MouseEvent = null) : void
      {
         if(this.starClkBoo)
         {
            this.starClkBoo = false;
            return;
         }
         if(this.hasEventListener(MouseEvent.CLICK))
         {
            this.removeEventListener(MouseEvent.CLICK,this.luckyClkHandle);
         }
         Tween.to(this.luckyTips,800,{
            "alpha":[1,0],
            "x":[340,38],
            "y":[220,43],
            "scaleX":[1,0.1],
            "scaleY":[1,0.1]
         },this.removeluckyTips);
      }
      
      private function removeluckyTips() : void
      {
         if(this.contains(this.luckyTips))
         {
            this.removeChild(this.luckyTips);
         }
      }
      
      private function initLucky() : void
      {
         if(!Global.XXPPdm)
         {
            SingleLoader.add("lang/ch/XXPP.swf",function(info:Object):void
            {
               Global.XXPPdm = info.applicationDomain;
               luckyTips.init();
               initluckyNum();
               starSprClkHandle();
            });
         }
         else
         {
            this.luckyTips.init();
            this.initluckyNum();
            this.starSprClkHandle();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value == true)
         {
            this.setStrArr();
            JingJiChangCGMessage.CG_GET_PAIMING();
            JingJiChangCGMessage.CG_GET_WAR_INFO();
            this.showQuestGuide();
            this.vipTxt.htmlText = this.vipStrArr[GameUnitManager.hero.vip];
            if(!this.bmTitle.bitmapData)
            {
               Utils.loadTitle("lang/ch/Arena_Imgs.swf","Title_Arena",this.bmTitle,{
                  "x":285,
                  "y":5
               },this,function():void
               {
                  bmTitle.x = (back.width - bmTitle.width) / 2;
               });
            }
            if(Model_farm.isInitFarm)
            {
               if(Boolean(UIManager.farmArrestList))
               {
                  UIManager.farmArrestList.visible = false;
               }
            }
            if(!this.isFirstEnter)
            {
               this.initLucky();
            }
            else
            {
               this.starSprClkHandle();
            }
            if(this.luckyNum != -2)
            {
               this.updateLuckNum(this.luckyNum);
            }
         }
         else
         {
            this.luckyClkHandle();
         }
         super.visible = value;
      }
      
      public function showSnowMan() : void
      {
         if(Model_jingJiChang.isSnowManTime == 1)
         {
            this.initSnowMan();
            if(!Global.Arena_Imgsdm)
            {
               regResource("lang/ch/Arena_Imgs.swf","Arena_Imgsdm");
               preFun();
            }
            else
            {
               this.initUI2();
            }
         }
         else if(Boolean(this.snowBack) && Boolean(this.snowBack.parent))
         {
            this.removeChild(this.snowBack);
         }
         this.reset(Model_jingJiChang.isSnowManTime == 1);
         this.resetPosition();
      }
      
      private function initSnowMan() : void
      {
         var snowTF:MyTextField = null;
         if(!this.snowBack)
         {
            this.snowBack = new Sprite();
            ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.snowBack,{
               "x":712,
               "y":40,
               "width":225,
               "height":392
            },Global.Img_Cdm);
            snowTF = ComponentUtil.getTextField("",this.snowBack,{
               "x":719,
               "y":385,
               "color":16764206,
               "size":12,
               "leading":4
            });
            snowTF.realWidth = 210;
            snowTF.multiline = true;
            snowTF.wordWrap = true;
            snowTF.mouseEnabled = true;
            snowTF.htmlText = LangConfig.getWord("80210",8);
            addEventListener(TextEvent.LINK,function(event:TextEvent):void
            {
               TipManager.update(LangConfig.getWord("80208",8));
            });
            addEventListener(FocusEvent.FOCUS_OUT,function(evt:Event):void
            {
               TipManager.hide();
            });
         }
      }
      
      override protected function initUI2() : void
      {
         if(!this.loadSnowMan)
         {
            ComponentUtil.getBitmap("SnowMan",this.snowBack,{
               "x":716,
               "y":44
            },Global.Arena_Imgsdm);
            this.warSnowMan = ComponentUtil.getButton("","Button_Fight",this.snowBack,{
               "x":761,
               "y":337,
               "textColor":16184781
            },Global.Arena_Imgsdm);
            this.warSnowMan.callBack = function(event:MouseEvent):void
            {
               JingJiChangCGMessage.CG_CHALLENGE_SNOWMAN();
            };
            this.loadSnowMan = true;
         }
         this.warSnowMan.enabled = Model_jingJiChang.canWarSnowMan == 1;
         if(!this.snowBack.parent)
         {
            addChild(this.snowBack);
         }
      }
      
      private function reset(show:Boolean) : void
      {
         if(show)
         {
            ComponentUtil.setPropertie(this.back,{
               "width":961,
               "height":442
            });
            if(Boolean(this.bmTitle.bitmapData))
            {
               this.bmTitle.x = (this.back.width - this.bmTitle.width) / 2;
            }
            moveBar.width = 961;
            CloseButton.x = 927;
         }
         else
         {
            ComponentUtil.setPropertie(this.back,{
               "width":731,
               "height":442
            });
            if(Boolean(this.bmTitle.bitmapData))
            {
               this.bmTitle.x = (this.back.width - this.bmTitle.width) / 2;
            }
            moveBar.width = 730;
            CloseButton.x = 697;
         }
      }
      
      public function showQuestGuide() : void
      {
         if(Model_quest.checkCurMainQStepType(Enum_quest_step_type.JING_JI))
         {
            this.resetPosition();
            QuestGuiManager.addKuang(this,405,92,65,300);
            QuestGuiManager.addJian(this,478,215,180);
         }
      }
      
      public function showCloseGuide() : void
      {
         QuestGuiManager.addKuang(this,CloseButton.x - 5,CloseButton.y - 5,CloseButton.width + 10,CloseButton.height + 10);
         QuestGuiManager.addJian(this,CloseButton.width + CloseButton.x + 3,CloseButton.height / 2 + CloseButton.y,180);
      }
      
      public function timeMinus(interval:int) : void
      {
         var now:int = getTimer();
         if(now - this.lastTime >= 1000)
         {
            --this._leftTime;
            if(this._leftTime < 0)
            {
               this._leftTime = 0;
            }
            if(this._leftTime != 0)
            {
               this.Time_text.text = String(DateUtil.getMSBySecond3(this._leftTime));
            }
            else
            {
               this.Time_text.text = "00:00";
               GameScene.instance.removeFrameCallBack(this.timeMinus);
            }
            if(this._leftTime == 0)
            {
               this.Time_text.textColor = 16763904;
               this.jumpTF.visible = false;
            }
            else
            {
               this.jumpTF.visible = true;
               this.Time_text.textColor = 16711680;
               this.jumpTF.filters = [];
            }
            this.updataTF(this._leftTime);
            this.lastTime = now;
         }
      }
      
      public function updataTF(value:int) : void
      {
         if(!this.tf)
         {
            return;
         }
         if(value == 0)
         {
            this.tf.visible = false;
         }
         else
         {
            this.tf.visible = true;
         }
         this.tf.text = String(DateUtil.getMSBySecond3(value));
      }
      
      private function resetWarInfo(_arr:Array = null) : void
      {
         var item:WarInfor = null;
         if(Boolean(_arr) && Boolean(_arr.length))
         {
            for each(item in _arr)
            {
               if(Boolean(item))
               {
                  item.dispose();
               }
            }
         }
         while(Boolean(_arr) && Boolean(_arr.length))
         {
            _arr.shift();
         }
      }
      
      private function reposWarData() : void
      {
         var item:WarInfor = null;
         var j:int = 0;
         var i:int = 0;
         while(i < this.warInfDataArr.length)
         {
            item = this.warInfDataArr[i];
            item.x = 0;
            item.y = j;
            j += item.height + 6;
            i++;
         }
      }
      
      public function updataZB(len:int, arr:Array) : void
      {
         var warItem:WarInfor = null;
         if(!this.ZBSpr)
         {
            this.ZBSpr = new Sprite();
            addChild(this.ZBSpr);
            this.maskZB = new Sprite();
            this.maskZB.graphics.beginFill(0,0);
            this.maskZB.graphics.drawRect(0,0,190,143);
            this.maskZB.graphics.endFill();
            addChild(this.maskZB);
            this.ZBSpr.mask = this.maskZB;
            ComponentUtil.setPropertie(this.ZBSpr,{
               "x":500,
               "y":98
            });
            ComponentUtil.setPropertie(this.maskZB,{
               "x":500,
               "y":98
            });
         }
         this.resetWarInfo(this.warInfDataArr);
         len = arr.length > 4 ? 4 : int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            warItem = WarInfor.instance;
            if(arr[i][5] == 0)
            {
               warItem.updata(HtmlUtil.font(arr[i][0],Model_jingJiChang.get_color[arr[i][1] - 1]) + LangConfig.getWord("334",0) + HtmlUtil.font(arr[i][2],Model_jingJiChang.get_color[arr[i][3] - 1]) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[arr[i][4]] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("335",0),"#3399cc"));
            }
            else if(arr[i][5] == 1)
            {
               warItem.updata(HtmlUtil.font(arr[i][0],Model_jingJiChang.get_color[arr[i][1] - 1]) + LangConfig.getWord("334",0) + HtmlUtil.font(arr[i][2],Model_jingJiChang.get_color[arr[i][3] - 1]) + "，" + HtmlUtil.font(LangConfig.getWord("138",0) + this.statusArr[arr[i][4]] + "","#ffffff") + "。" + HtmlUtil.font(LangConfig.getWord("336",0),"#33cc99")) + "。";
            }
            this.ZBSpr.addChild(warItem);
            this.warInfDataArr.push(warItem);
            i++;
         }
         this.reposWarData();
      }
      
      public function paiHangHandle(e:MouseEvent) : void
      {
         UIManager.pai_ming.visible = !UIManager.pai_ming.visible;
         if(UIManager.pai_ming.visible)
         {
            JingJiChangCGMessage.CG_PAIHANG();
         }
      }
      
      public function ranTZHandle(e:MouseEvent) : void
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("337",0));
      }
      
      public function getTips() : void
      {
         var temPay:int = 0;
         UIManager.storeTip.wpid = 0;
         UIManager.storeTip.isStore = false;
         UIManager.storeTip.isStore_youhui = false;
         if(this._leftTime % 60 == 0)
         {
            temPay = int(this._leftTime / 60);
         }
         else
         {
            temPay = int(this._leftTime / 60) + 1;
         }
         if(this._leftTime > 0)
         {
            if(!UIManager.storeTip.visible)
            {
               UIManager.storeTip.visible = true;
               UIManager.storeTip._type = LangConfig.getWord("140",0);
               UIManager.storeTip._pai_ming = int(this.RYPaiMing_text.text);
            }
            UIManager.storeTip.Imformate_text.text = LangConfig.getWord("341",0) + String(temPay) + LangConfig.getWord("342",0);
         }
         else
         {
            if(!UIManager.storeTip.visible)
            {
               UIManager.storeTip.visible = true;
               UIManager.storeTip._type = LangConfig.getWord("141",0);
               UIManager.storeTip._pai_ming = int(this.RYPaiMing_text.text);
            }
            UIManager.storeTip.Imformate_text.text = "";
            UIManager.storeTip.Imformate_text.text = LangConfig.getWord("176",0) + String(20) + LangConfig.getWord("137",0);
            UIManager.storeTip.tiaoZhan_cost = 20;
         }
      }
      
      protected function itemOnClick(event:MouseEvent) : void
      {
         var item:View_tiaozhanItem = event.currentTarget as View_tiaozhanItem;
         if(this.curItem == item)
         {
            return;
         }
         if(Boolean(this.curItem))
         {
            this.curItem.choose = false;
         }
         item.choose = true;
         this.curItem = item;
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         UIManager.isDragPanel = true;
         UIManager.curDragPanel = this;
         startDrag();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.JingJiChangCGMessage;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.modules.jingJiChang.View_jingJiChang;
import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextFormatAlign;

class WarInfor extends Sprite
{
   
   private static var pool:Array = [];
   
   private var tf:MyTextField;
   
   public var warId:Number;
   
   public function WarInfor()
   {
      super();
      this.tf = ComponentUtil.getTextField("",this,{
         "realWidth":188,
         "realHeight":60,
         "multiline":true,
         "wordWrap":true,
         "leading":3,
         "textColor":11515029
      });
      this.tf.mouseEnabled = true;
      this.tf.addEventListener(TextEvent.LINK,this.linkHandle);
   }
   
   public static function get instance() : WarInfor
   {
      if(Boolean(pool.length))
      {
         return pool.pop();
      }
      return new WarInfor();
   }
   
   private function linkHandle(e:TextEvent) : void
   {
      if(e.text == this.warId.toString())
      {
         if(View_jingJiChang._xuanYaoTimes >= 1)
         {
            JingJiChangCGMessage.CG_XUANYAO(this.warId);
         }
         else
         {
            if(GameUnitManager.hero.money < 8)
            {
               UIManager.centerBroadcast.addMsg("元宝不足");
               return;
            }
            View_Alert.show("确定花费" + HtmlUtil.font("8元宝",ColorConstant.getColorStr(ColorConstant.BLUE)) + "将您的辉煌战绩炫耀一番么？",View_Alert.OK_CANCAL,function():void
            {
               JingJiChangCGMessage.CG_XUANYAO(warId);
            },null,null,null,310,"","",TextFormatAlign.CENTER);
         }
         return;
      }
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,int(e.text));
   }
   
   public function updata(str:String) : void
   {
      this.tf.htmlText = str;
   }
   
   override public function get height() : Number
   {
      return this.tf.textHeight;
   }
   
   override public function get width() : Number
   {
      return this.tf.textWidth;
   }
   
   public function dispose() : void
   {
      this.tf.text = "";
      this.warId = 0;
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      pool.push(this);
   }
}

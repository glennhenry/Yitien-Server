package scene
{
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextFieldType;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.HtmlUtil;
   import manager.KeyBoardConst;
   import manager.StrFilter;
   import manager.Utils;
   import net.LoginCGMessage;
   
   public class CreateSceneNew extends IScene
   {
      
      private static var _instance:CreateSceneNew;
      
      private static var strArr:Array = ["Text_TianDao","Text_XiaoYao","Text_YiXian","Text_CiKe"];
      
      private static var firstGetName:Boolean = true;
      
      private static var isShowBtnEff:Boolean = true;
      
      private static var UnWords:Array = [];
      
      private static var isChange:Boolean = false;
      
      private static var isShowTfEff:Boolean = true;
      
      private static var tipName:String = "";
      
      private const TO_WEIBO:String = "分享到QQ微博";
      
      private const TO_QQGAME:String = "分享到QQ大厅";
      
      private const TO_QQPLUS:String = "分享到Q+平台";
      
      private const ST_GUANFANG_WEIBAO:String = "收听倚天官方微博";
      
      private var arr_qzone:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var arr_pengyou:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var arr_qqgame:Array = [this.TO_QQGAME,this.ST_GUANFANG_WEIBAO];
      
      private var arr_3366:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var arr_qplus:Array = [this.TO_QQPLUS,this.ST_GUANFANG_WEIBAO];
      
      private var arr_aiwan:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var arr_website:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var arr_box:Array = [this.TO_WEIBO,this.ST_GUANFANG_WEIBAO];
      
      private var inputText:MyTextField;
      
      private var checkBoxVec:Vector.<CheckBox> = new Vector.<CheckBox>();
      
      private var tipsTxt:MyTextField;
      
      private var jobIcon:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var pattern:RegExp;
      
      private var choosenIcon:Bitmap;
      
      private var tipsCon:Sprite;
      
      private var startTips:Sprite;
      
      private var nowJobS:Sprite;
      
      private var count:int;
      
      private var roleName:String;
      
      private var nowCh:CheckBox;
      
      private var enterBtn:Sprite;
      
      private var cheVec:Vector.<CheckBox> = new Vector.<CheckBox>();
      
      public function CreateSceneNew()
      {
         super();
      }
      
      public static function get instance() : CreateSceneNew
      {
         if(!_instance)
         {
            _instance = new CreateSceneNew();
         }
         return _instance;
      }
      
      public static function strHd(str:String) : Boolean
      {
         var i:int = 0;
         var _str:String = null;
         var reg:RegExp = null;
         var _arr:Array = "綡,綂,提示,GM,客服,系统,QQ,qq,黄钻,会员,VIP,vip,Vip,gm,GM,活动,奖励,礼包".split(",");
         var dataArr:Array = [];
         i = 0;
         while(i < _arr.length)
         {
            _str = _arr[i];
            reg = new RegExp(_str,"gi");
            dataArr.push(reg);
            i++;
         }
         UnWords = dataArr;
         i = 0;
         while(i < dataArr.length)
         {
            if(dataArr[i].lastIndex != 0)
            {
               dataArr[i].lastIndex = 0;
            }
            if(Boolean(dataArr[i].test(str)))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      override public function show() : void
      {
         var i:int;
         var _arr:Array;
         var _ranN:int;
         var ss:String = null;
         var sp:Sprite = null;
         var _style:String = null;
         var chBox:CheckBox = null;
         var arr:Array = null;
         var _bm:Bitmap = null;
         var _bm2:Bitmap = null;
         var _i:int = 0;
         var cheBox:CheckBox = null;
         super.show();
         ComponentUtil.getBitmap("Back_Imgs",this,{
            "x":0,
            "y":60
         },Global.createDm);
         i = 0;
         i = 0;
         while(i < 4)
         {
            ss = strArr[i];
            sp = new Sprite();
            addChild(sp);
            this.jobIcon.push(sp);
            sp.buttonMode = true;
            sp.tabIndex = i + 1;
            sp.addEventListener(MouseEvent.CLICK,this.jobSelect);
            ComponentUtil.setPropertie(sp,{
               "x":60 + 82 * i,
               "y":100
            });
            ComponentUtil.getBitmap(ss,sp,null,Global.createDm);
            i++;
         }
         this.choosenIcon = ComponentUtil.getBitmap("Round_02",this,{"visible":false},Global.createDm);
         this.enterBtn = new Sprite();
         addChild(this.enterBtn);
         ComponentUtil.setPropertie(this.enterBtn,{
            "x":120,
            "y":335
         });
         ComponentUtil.getBitmap("Button_Start_up",this.enterBtn,null,Global.createDm);
         this.enterBtn.buttonMode = true;
         this.enterBtn.addEventListener(MouseEvent.CLICK,this.enterGame);
         this.enterBtn.addEventListener(MouseEvent.MOUSE_OVER,this.removeBtnEff);
         this.enterBtn.addEventListener(MouseEvent.MOUSE_OUT,this.showBtnEff);
         this.startTips = new Sprite();
         addChild(this.startTips);
         ComponentUtil.setPropertie(this.startTips,{
            "x":324,
            "y":360
         });
         ComponentUtil.getScaleBitmap("Back_StartText",[40,24,2,2],this.startTips,{
            "x":0,
            "y":0,
            "width":146,
            "height":61
         },Global.createDm);
         ComponentUtil.getTextField("点击开始游戏！",this.startTips,{
            "x":351 - 324,
            "y":389 - 360,
            "color":16777215,
            "size":14,
            "leading":0
         });
         this.inputText = ComponentUtil.getTextField("名字",this,{
            "x":157,
            "y":240,
            "color":16777215,
            "size":14,
            "leading":0,
            "realWidth":143,
            "realHeight":20,
            "type":TextFieldType.INPUT,
            "maxChars":6
         });
         this.inputText.doubleClickEnabled = true;
         this.tipsCon = new Sprite();
         addChild(this.tipsCon);
         ComponentUtil.setPropertie(this.tipsCon,{
            "x":146,
            "y":204
         });
         this.tipsTxt = ComponentUtil.getTextField("我我我我我我",this.tipsCon,{
            "x":0,
            "y":0,
            "multiline":true,
            "wordWrap":true,
            "realWidth":188,
            "realHeight":40,
            "color":16646144
         });
         _arr = ["CheckBox02","CheckBox03"];
         i = 0;
         while(i < 2)
         {
            _style = _arr[i];
            chBox = ComponentUtil.getCheckBox("",_style,this,{
               "x":113 + 119 * i,
               "y":176,
               "color":16777215
            },Global.createDm);
            chBox.tabIndex = i + 1;
            chBox.clickFun = this.cheBoxHd;
            this.checkBoxVec.push(chBox);
            i++;
         }
         ComponentUtil.getButton("","Button_Dice",this,{
            "x":306,
            "y":236,
            "textColor":16184781,
            "callBack":function():void
            {
               selectName();
               tipName = "";
               var _temp_1:* = enterBtn;
               enterBtn.mouseEnabled = true;
               _temp_1.buttonMode = true;
               setTip(tipName);
               removeTfEff();
               if(!isShowBtnEff)
               {
                  showBtnEff();
               }
            }
         },Global.createDm);
         if(Boolean(Global.pf))
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Global.pf == Enum_SPStr.CHITU || Enum_SPStr.isIwan(Global.pf))
            {
               arr = this["arr_" + Global.pf];
            }
            else if(Enum_SPStr.isUnion(Global.pf))
            {
               arr = this.arr_aiwan;
            }
            else
            {
               arr = [];
            }
            _bm = Utils.getLoadBitmap("resource/image/shareIcon/shareIcon.png");
            ComponentUtil.setPropertie(_bm,{
               "x":449,
               "y":359
            });
            addChild(_bm);
            _bm2 = Utils.getLoadBitmap("resource/image/shareIcon/shareIcon.png");
            ComponentUtil.setPropertie(_bm2,{
               "x":449,
               "y":320
            });
            addChild(_bm2);
            _i = 0;
            while(_i < arr.length)
            {
               cheBox = new CheckBox(arr[_i],"CheckBox",ComponentUtil.domain,true);
               addChild(cheBox);
               cheBox.x = 118 + 449;
               cheBox.y = 315 + 85 - 40 * _i;
               cheBox.color = 8098481;
               this.cheVec.push(cheBox);
               _i++;
            }
         }
         this.pattern = /([^一-龥0-9A-Za-z])+/;
         this.inputText.addEventListener(MouseEvent.DOUBLE_CLICK,function():void
         {
            inputText.setSelection(0,inputText.text.length);
         });
         this.inputText.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void
         {
            if(e.keyCode == KeyBoardConst.ENTER)
            {
               enterGame(new MouseEvent(MouseEvent.CLICK));
            }
         });
         this.inputText.addEventListener(Event.CHANGE,function(e:Event):void
         {
            isChange = true;
            StrFilter.load(inputText.text,function(text:String):void
            {
               if(pattern.test(text))
               {
                  tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_COM + "</font>";
                  removeBtnEff();
                  setTip(tipName);
                  isShowTfEff = true;
                  enterBtn.buttonMode = enterBtn.mouseEnabled = false;
                  cheInputTxt();
               }
               else if(inputText.length < 2 && !pattern.test(inputText.text))
               {
                  tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.ZHONGWENMING_CHANGDU + "</font>";
                  removeBtnEff();
                  setTip(tipName);
                  enterBtn.buttonMode = enterBtn.mouseEnabled = false;
                  isShowTfEff = true;
                  cheInputTxt();
               }
               else if(StrFilter.hasUnRegisterString(inputText.text))
               {
                  tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + StrFilter.takeUnRegisterString(HtmlUtil.font(inputText.text,"#fe0000")) + "</font>";
                  removeBtnEff();
                  setTip(tipName);
                  enterBtn.buttonMode = enterBtn.mouseEnabled = false;
                  isShowTfEff = true;
                  cheInputTxt();
               }
               else
               {
                  tipName = "";
                  enterBtn.buttonMode = enterBtn.mouseEnabled = true;
                  setTip(tipName);
                  removeTfEff();
                  if(!isShowBtnEff)
                  {
                     showBtnEff();
                  }
               }
            });
         });
         _ranN = Math.random() * 1;
         this.cheBoxHd(this.checkBoxVec[_ranN]);
         this.jobIcon[Global.randJob - 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.selectName();
         this.getQQName();
         this.showBtnEff();
      }
      
      private function jobSelect(e:MouseEvent) : void
      {
         var sp:Sprite = e.target as Sprite;
         if(Boolean(this.nowJobS) && this.nowJobS == sp)
         {
            return;
         }
         if(Boolean(this.nowJobS))
         {
            this.nowJobS.filters = [];
         }
         sp.filters = Util.glowde45c7;
         this.nowJobS = sp;
         if(firstGetName)
         {
            if(!this.choosenIcon.visible)
            {
               this.choosenIcon.visible = true;
            }
            ComponentUtil.setPropertie(this.choosenIcon,{
               "x":this.nowJobS.x - 8,
               "y":this.nowJobS.y - 30
            });
         }
         else
         {
            this.showEff();
         }
      }
      
      private function showEff() : void
      {
         var _nn:int = 0;
         _nn = int(setTimeout(function():void
         {
            if(!choosenIcon.visible)
            {
               choosenIcon.visible = true;
            }
            ComponentUtil.setPropertie(choosenIcon,{
               "x":nowJobS.x - 8,
               "y":nowJobS.y - 30
            });
            clearTimeout(_nn);
         },20));
      }
      
      private function btnEff(changNum:int) : void
      {
         var changeColor:Array;
         var n:int;
         if(!isShowBtnEff)
         {
            return;
         }
         changeColor = [new GlowFilter(16776960,0.6,changNum,changNum,changNum,1)];
         this.enterBtn.filters = changeColor;
         n = int(setTimeout(function():void
         {
            ++count;
            var _n:* = 1;
            if(int(count / 4) % 2 == 0)
            {
               _n = 1;
            }
            else
            {
               _n = -1;
            }
            btnEff(changNum = changNum + _n);
         },40));
      }
      
      private function removeBtnEff(e:MouseEvent = null) : void
      {
         isShowBtnEff = false;
         this.enterBtn.filters = [];
      }
      
      private function showBtnEff(e:MouseEvent = null) : void
      {
         isShowBtnEff = true;
         this.count = 0;
         this.btnEff(1);
      }
      
      private function enterGame(e:MouseEvent) : void
      {
         if(!this.enterBtn.mouseEnabled)
         {
            return;
         }
         this.enterBtn.mouseEnabled = true;
         if(this.inputText.text.length == 0)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.NAME_NOT_NULL + "</font>";
            this.setTip(tipName);
            isShowTfEff = true;
            this.cheInputTxt();
         }
         else if(this.inputText.text.length < 2 || this.inputText.text.length > 6)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_LENGHT + "</font>";
            this.setTip(tipName);
            isShowTfEff = true;
            this.cheInputTxt();
         }
         else
         {
            if(!this.pattern.test(this.inputText.text))
            {
               this.enterBtn.mouseEnabled = false;
               StrFilter.load(this.inputText.text,function(text:String):void
               {
                  var isShare:int = 0;
                  var isShouTing:int = 0;
                  var len:int = 0;
                  var i:int = 0;
                  var _sex:int = 0;
                  var chItem:CheckBox = null;
                  var pform:String = null;
                  if(StrFilter.hasUnRegisterString(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + StrFilter.takeUnRegisterString(HtmlUtil.font(text,"#fe0000")) + "</font>";
                     enterBtn.mouseEnabled = true;
                     setTip(tipName);
                     isShowTfEff = true;
                     cheInputTxt();
                     return;
                  }
                  if(strHd(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + "包含以下非法字符:" + HtmlUtil.font(getUnStr(text),"#fe0000") + "</font>";
                     enterBtn.mouseEnabled = true;
                     setTip(tipName);
                     isShowTfEff = true;
                     cheInputTxt();
                     return;
                  }
                  isShare = 0;
                  isShouTing = 0;
                  len = int(cheVec.length);
                  i = 0;
                  while(i < len)
                  {
                     pform = cheVec[i].text;
                     if(cheVec[i].selected)
                     {
                        if(pform == TO_WEIBO || pform == TO_QQGAME || pform == TO_QQPLUS)
                        {
                           isShare = 1;
                        }
                        else if(pform == ST_GUANFANG_WEIBAO)
                        {
                           isShouTing = 1;
                        }
                     }
                     i++;
                  }
                  for each(chItem in checkBoxVec)
                  {
                     if(chItem.selected)
                     {
                        _sex = chItem.tabIndex;
                     }
                  }
                  LoginCGMessage.CG_CREATE_ROLE(nowJobS.tabIndex,_sex,inputText.text,isShare,isShouTing);
               });
               return;
            }
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_COM + "</font>";
            this.setTip(tipName);
            isShowTfEff = true;
            this.cheInputTxt();
         }
      }
      
      private function getUnStr(str:String) : String
      {
         var _s:String = "";
         var i:int = 0;
         while(i < UnWords.length)
         {
            if(UnWords[i].lastIndex != 0)
            {
               UnWords[i].lastIndex = 0;
            }
            if(Boolean(UnWords[i].test(str)))
            {
               _s += UnWords[i].source + " ";
            }
            i++;
         }
         return _s;
      }
      
      private function getQQName() : void
      {
      }
      
      private function setQQName(e:Event) : void
      {
         var str:String = e.target.data.toString();
         this.inputText.text = str;
         if(this.inputText.text.length < 2 || this.inputText.text.length > 6)
         {
            this.selectName();
         }
      }
      
      private function cheInputTxt(tfChangeNum:Boolean = false) : void
      {
         var n:int;
         if(!isShowTfEff)
         {
            this.tipsCon.filters = [];
            return;
         }
         if(!tfChangeNum)
         {
            this.tipsCon.filters = Util.glowFFFF00;
         }
         else
         {
            this.tipsCon.filters = [];
         }
         this.startTips.visible = false;
         n = int(setTimeout(function():void
         {
            cheInputTxt(!tfChangeNum);
         },440));
      }
      
      private function removeTfEff() : void
      {
         isShowTfEff = false;
         this.tipsCon.filters = [];
         this.startTips.visible = true;
      }
      
      private function selectName() : void
      {
         if(this.checkBoxVec[0].selected)
         {
            this.roleName = CreaterScene_model.getRandomUserName(1);
         }
         else if(this.checkBoxVec[1].selected)
         {
            this.roleName = CreaterScene_model.getRandomUserName(2);
         }
         this.inputText.text = this.roleName;
         Global.stage.focus = this.inputText;
         tipName = "";
         this.setTip(tipName);
         if(firstGetName)
         {
            firstGetName = false;
            Global.stage.focus = this.inputText;
         }
      }
      
      private function cheBoxHd(e:CheckBox) : void
      {
         if(Boolean(this.nowCh) && this.nowCh == e)
         {
            if(Boolean(this.nowCh))
            {
               this.nowCh.selected = true;
            }
            return;
         }
         if(Boolean(this.nowCh))
         {
            this.nowCh.selected = false;
         }
         e.selected = true;
         this.nowCh = e;
      }
      
      public function nameRepeat() : void
      {
         this.setTip(Model_initStr.CHONGFU_NAME);
         this.enterBtn.mouseEnabled = true;
      }
      
      private function setTip(tipName:String) : void
      {
         this.tipsTxt.htmlText = tipName;
      }
      
      public function dealShare() : void
      {
         var shareUrl:String = null;
         var pform:String = null;
         var encodeUrl:String = null;
         var loader:URLLoader = null;
         var url:URLRequest = null;
         var s1:String = null;
         var s2:String = null;
         Utils.print("dealShare");
         var len:int = int(this.cheVec.length);
         var i:int = 0;
         while(i < len)
         {
            if(this.cheVec[i].selected)
            {
               pform = this.cheVec[i].text;
               if(pform == this.TO_WEIBO || pform == this.ST_GUANFANG_WEIBAO)
               {
                  if(pform == this.TO_WEIBO)
                  {
                     s1 = "http://ctc.i.gtimg.cn/qzonestyle/act/qzone_app_img/app100621282_100621282_75.png";
                     s2 = "http://rc.qzone.qq.com/myhome/100621282";
                     shareUrl = "http://api2.app100621282.twsapp.com/openapi.php?mod=share&op=sendblog&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&discrpt=" + Model_initStr.YT_DISCRIPT + "&url" + encodeURI(s2) + "&pic_url=" + encodeURI(s1) + "&r=" + getTimer();
                  }
                  if(pform == this.ST_GUANFANG_WEIBAO)
                  {
                     this.isToMicro();
                  }
               }
               else if(pform == this.TO_QQGAME || pform == this.ST_GUANFANG_WEIBAO)
               {
                  if(pform == this.TO_QQGAME)
                  {
                     shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=setfeed&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&r=" + getTimer();
                  }
                  if(pform == this.ST_GUANFANG_WEIBAO)
                  {
                     this.isToMicro();
                  }
               }
               else if(pform == this.TO_QQPLUS || pform == this.ST_GUANFANG_WEIBAO)
               {
                  if(pform == this.TO_QQPLUS)
                  {
                     shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=qplusshare&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&title=" + Model_initStr.YT_TITLE + "&summary=" + Model_initStr.YT_SUMMARY + "&comment=" + Model_initStr.YT_DISCRIPT + "&r=" + getTimer();
                  }
                  if(pform == this.ST_GUANFANG_WEIBAO)
                  {
                     this.isToMicro();
                  }
               }
               encodeUrl = encodeURI(shareUrl);
               loader = new URLLoader();
               url = new URLRequest(encodeUrl);
               url.method = URLRequestMethod.GET;
               loader.dataFormat = URLLoaderDataFormat.TEXT;
               loader.load(url);
            }
            i++;
         }
      }
      
      private function isToMicro() : void
      {
      }
      
      override public function resize() : void
      {
         x = (Global.stage.stageWidth - 437) / 2;
         y = (Global.stage.stageHeight - 331) / 2;
      }
   }
}


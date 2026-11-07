package com.yiTian.scene
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.KeyBoardConst;
   import com.yiTian.data.model.Model_initStr;
   import com.yiTian.net.message.cg.LoginCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class CreateScene extends IScene
   {
      
      private static var _instance:CreateScene;
      
      private static var textInput:TextField;
      
      private static var textFild:MyTextField;
      
      private static var tipsBg:TipBack;
      
      public static var bgTip:Bitmap;
      
      private static var roundX:int;
      
      private static var roundY:int;
      
      public static var infobtn:Object;
      
      private static var tipName:String = "";
      
      private static var container1:Sprite = new Sprite();
      
      public static var isInit:Boolean = false;
      
      private static var UnWords:Array = [];
      
      private var background:Bitmap = new Bitmap();
      
      private var container:Sprite = new Sprite();
      
      private var jobs:Array = ["11","21","31","41","12","22","32","42"];
      
      private var pos_arr:Array = [[180,330],[487,385],[810,130],[860,408]];
      
      private var job_pos:Array = [[142.9 + 183,210.95 - 5],[321.9 + 185,248.95 - 7],[509.9 + 176,197.95 - 13],[696.9 + 182,277.95 - 13],[221.9 + 190,188.95 - 7],[394.95 + 192,262.95 + 3],[582.9 + 198,178.95 - 14],[783.9 + 190,249.95 - 5]];
      
      private var now:Icon;
      
      private var pattern:RegExp;
      
      private var icon:Icon;
      
      private var select_icon:Select_Icon;
      
      private var seziBtn:Button;
      
      private var roleName:String;
      
      private var isChange:Boolean = false;
      
      private var tips:TextField = new TextField();
      
      private var preName:String;
      
      private var carer:int;
      
      private var tip_maneger:TipHandle;
      
      private var jop_title:GetJopTitle;
      
      private const TO_WEIBO:String = "分享到QQ微博";
      
      private const TO_QQGAME:String = "分享到QQ大厅";
      
      private const TO_QQPLUS:String = "分享到Q+平台";
      
      private var arr_qzone:Array = [this.TO_WEIBO];
      
      private var arr_pengyou:Array = [this.TO_WEIBO];
      
      private var arr_qqgame:Array = [this.TO_QQGAME];
      
      private var arr_3366:Array = [this.TO_WEIBO];
      
      private var arr_qplus:Array = [this.TO_QQPLUS];
      
      private var arr_aiwan:Array = [this.TO_WEIBO];
      
      private var arr_website:Array = [this.TO_WEIBO];
      
      private var cheContainer:Sprite;
      
      private var cheVec:Vector.<CheckBox> = new Vector.<CheckBox>();
      
      private var OVER1_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER2_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER3_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER4_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var effect_arr:Array = [this.OVER1_EFFECT,this.OVER2_EFFECT,this.OVER3_EFFECT,this.OVER4_EFFECT];
      
      private var grid_dis:DisplayObject;
      
      private var ranNameBtn:Button;
      
      private var container2:Sprite = new Sprite();
      
      private var icon_arr:Array = [];
      
      private var select_icon_arr:Array = [];
      
      private var chooAble:Boolean = false;
      
      private var FIRST_NAME:Array = new Array();
      
      private var SEND_MAN_NAME_1:Array = new Array();
      
      private var SEND_MAN_NAME_2:Array = new Array();
      
      private var SEND_WOMEN_NAME_1:Array = new Array();
      
      private var SEND_WOMEN_NAME_2:Array = new Array();
      
      public function CreateScene()
      {
         super();
      }
      
      public static function get instance() : CreateScene
      {
         if(!_instance)
         {
            _instance = new CreateScene();
         }
         return _instance;
      }
      
      public static function checkUse(result:String) : void
      {
         tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + result + "</font>";
         container1.x = -2;
         container1.y = 35;
         _instance.setTip(tipName);
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
      
      public static function add_idol() : void
      {
         var loadurl:String = "http://s2.app100621282.qqopenapp.com/add_idol.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,loaded);
         loader.load(url);
      }
      
      private static function loaded(e:Event) : void
      {
         Utils.print("add idol",e.target.data);
      }
      
      override public function show() : void
      {
         var i:int;
         var textformat:TextFormat;
         var number:int;
         var arr:Array = null;
         var _i:int = 0;
         var cheBox:CheckBox = null;
         super.show();
         this.cheContainer = new Sprite();
         this.cheContainer.x = 50;
         this.cheContainer.y = 30;
         if(Boolean(Global.pf))
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QQ3366 || Enum_SPStr.isIwan(Global.pf) || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG)
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
            this.cheContainer.addChild(Utils.getLoadBitmap("resource/image/shareIcon/shareIcon.png"));
            _i = 0;
            while(_i < arr.length)
            {
               cheBox = new CheckBox(arr[_i],"CheckBox",ComponentUtil.domain,true);
               this.cheContainer.addChild(cheBox);
               cheBox.x = 118;
               cheBox.y = 40 + 22 * _i;
               cheBox.color = 8098481;
               this.cheVec.push(cheBox);
               _i++;
            }
         }
         addChild(this.container2);
         addChild(this.cheContainer);
         this.pattern = /([^一-龥0-9A-Za-z])+/;
         textFild = ComponentUtil.getTextField("",null,{
            "multiline":true,
            "wordWrap":true,
            "leading":5,
            "color":10944511,
            "bold":true,
            "y":20,
            "x":2,
            "realWidth":140
         });
         textFild.autoSize = TextFieldAutoSize.CENTER;
         tipsBg = new TipBack();
         tipsBg.addChild(textFild);
         tipsBg.x = 493;
         tipsBg.y = 477;
         container1.addChild(tipsBg);
         tipName = "<td><nobr><font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + "" + "</font></nobr></td>";
         this.setTip(tipName);
         container1.x = -2;
         container1.y = 35;
         MassLoader.add("lang/" + Global.config.lang + "/createButton.swf",function(info:Object):void
         {
            infobtn = info;
            infobtn.content.x = 450;
            infobtn.content.y = 330;
            infobtn.content.addEventListener(MouseEvent.CLICK,enterGame);
            infobtn.content.buttonMode = true;
            container.addChildAt(infobtn.content,container.getChildIndex(container1));
         });
         i = 0;
         while(i < this.jobs.length)
         {
            this.icon = new Icon(this.jobs[i],this.job_pos[i][0],this.job_pos[i][1],[this.jobs[i].charAt(0),this.jobs[i].charAt(1)]);
            this.select_icon = new Select_Icon(this.jobs[i],this.job_pos[i][0],this.job_pos[i][1],[this.jobs[i].charAt(0),this.jobs[i].charAt(1)]);
            this.container.addChild(this.icon);
            this.container.addChild(this.select_icon);
            this.icon_arr.push(this.icon);
            this.icon.index = i;
            this.icon.addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
            this.icon.addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
            this.select_icon_arr.push(this.select_icon);
            i++;
         }
         this.tip_maneger = new TipHandle();
         this.container.addChild(this.tip_maneger);
         this.tip_maneger.visible = false;
         this.jop_title = new GetJopTitle();
         this.container.addChild(this.jop_title);
         this.jop_title.visible = false;
         this.getInterFace();
         this.FIRST_NAME = Model_initStr.FIRST_NAME;
         this.SEND_MAN_NAME_1 = Model_initStr.SEND_MAN_NAME_1;
         this.SEND_MAN_NAME_2 = Model_initStr.SEND_MAN_NAME_2;
         this.SEND_WOMEN_NAME_1 = Model_initStr.SEND_WOMEN_NAME_1;
         this.SEND_WOMEN_NAME_2 = Model_initStr.SEND_WOMEN_NAME_2;
         textInput = ComponentUtil.getTextField(this.getRandomUserName(1 + int(Math.random() * 2)),null,{
            "size":14,
            "realWidth":150,
            "height":30,
            "width":150,
            "y":415 + 20,
            "maxChars":6,
            "type":TextFieldType.INPUT,
            "multiline":false,
            "wordWrap":false
         });
         this.container.addChild(textInput);
         textformat = new TextFormat();
         textformat.align = "center";
         textInput.defaultTextFormat = textformat;
         this.preName = textInput.text;
         textInput.x = 665;
         textInput.doubleClickEnabled = true;
         Global.stage.focus = textInput;
         textInput.addEventListener(MouseEvent.DOUBLE_CLICK,function():void
         {
            textInput.setSelection(0,textInput.text.length);
         });
         textInput.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void
         {
            if(e.keyCode == KeyBoardConst.ENTER)
            {
               enterGame(new MouseEvent(MouseEvent.CLICK));
            }
         });
         textInput.addEventListener(Event.CHANGE,function(e:Event):void
         {
            isChange = true;
            if(pattern.test(textInput.text))
            {
               tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_COM + "</font>";
            }
            else if(textInput.length < 2 && !pattern.test(textInput.text))
            {
               tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.ZHONGWENMING_CHANGDU + "</font>";
            }
            else
            {
               tipName = "<th><nobr><font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.WITH_NAME + "<font color=\'#3be450\'>[" + textInput.text + "]</font>" + Model_initStr.ENTER_GAME + "</font></nobr></th>";
            }
            setTip(tipName);
         });
         textInput.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            if(pattern.test(textInput.text))
            {
               tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.NAME_COM + "</font>";
            }
            else
            {
               tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.INPUT_NAME + "</font>";
            }
            setTip(tipName);
         });
         this.tips.text = Model_initStr.CLICK_IN_NAME;
         this.tips.textColor = 16776960;
         this.tips.x = 192;
         this.tips.y = 247;
         this.container.addChild(this.tips);
         this.tips.visible = false;
         textInput.text = "";
         this.container.addChild(container1);
         addChild(this.container);
         number = int(1 + Math.random() * 8);
         this.carer = Math.round(number / 2);
         this.getRamJop();
         this.getQQName();
         isInit = true;
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         var tem_icon:Icon = null;
         tem_icon = e.target as Icon;
         if(!tem_icon.choosed)
         {
            tem_icon.filters = Util.glowFFFFFF;
         }
         tem_icon.cacheAsBitmap = true;
         tem_icon.cacheAsBitmap = true;
         tem_icon.transform.colorTransform = this.effect_arr[Enum_job.getBaseJob(tem_icon._job_index) - 1];
         this.select_icon_arr[tem_icon.index].visible = true;
         tem_icon.visible = true;
         this.show_tip(tem_icon._job_index);
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         var tem_icon:Icon = e.target as Icon;
         if(!tem_icon.choosed)
         {
            this.select_icon_arr[tem_icon.index].visible = false;
            tem_icon.alpha = 0;
         }
         this.remove_tip(tem_icon._job_index);
      }
      
      private function setLightChoose(instance_icon:Icon) : void
      {
         instance_icon.filters = Util.glowFFFF00;
         instance_icon.cacheAsBitmap = true;
         instance_icon.cacheAsBitmap = true;
         instance_icon.transform.colorTransform = this.effect_arr[instance_icon._job_index - 1];
      }
      
      public function getInterFace() : void
      {
         var back:DisplayObject = ComponentUtil.getDisplayObject("Choose",this.container2,{
            "x":190,
            "y":-10
         });
         this.ranNameBtn = ComponentUtil.getButton("","Button_Dice",container1,{
            "x":812,
            "y":397
         });
         this.ranNameBtn.addEventListener(MouseEvent.CLICK,this.ranNameHandle);
      }
      
      private function getRamJop() : void
      {
         trace("跑这里来。。。");
         var temN:int = Math.random() * this.icon_arr.length;
         this.select(this.icon_arr[temN]);
      }
      
      public function ranNameHandle(e:MouseEvent = null) : void
      {
         if(!this.chooAble)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.CHOOSE_HERO + "</font>";
            this.setTip(tipName);
            return;
         }
         this.isChange = false;
         this.selectName();
      }
      
      private function changeName() : void
      {
         trace("data information",this.now.data[0],this.now.data[1]);
         if(this.preName == textInput.text)
         {
            this.selectName();
            this.preName = textInput.text;
         }
         this.selectName();
      }
      
      private function selectName() : void
      {
         if(this.now.data[1] == 1)
         {
            this.roleName = this.getRandomUserName(1);
         }
         else if(this.now.data[1] == 2)
         {
            this.roleName = this.getRandomUserName(2);
         }
         trace(this.roleName);
         textInput.text = this.roleName;
         Global.stage.focus = textInput;
         textInput.setSelection(0,this.preName.length);
         tipName = "<td><nobr><font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.DEFAULT_NAME + "</font></nobr></td>";
         this.setTip(tipName);
      }
      
      private function setTip(tipName:String) : void
      {
         textFild.width = 131;
         textFild.htmlText = tipName;
         tipsBg.setWidth = textFild.width + 10;
         tipsBg.setHeight = textFild.height + 32;
      }
      
      public function nameRepeat() : void
      {
         this.setTip(Model_initStr.CHONGFU_NAME);
         infobtn.content.mouseEnabled = true;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         this.selectName();
         this.preName = textInput.text;
         Global.stage.focus = textInput;
         textInput.setSelection(0,this.preName.length);
      }
      
      private function enterGame(e:MouseEvent) : void
      {
         if(!infobtn.content.mouseEnabled)
         {
            return;
         }
         infobtn.content.mouseEnabled = true;
         if(!this.chooAble && Boolean(textInput.text.length))
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.CHOOSE_ONE_HERO + "</font>";
            this.setTip(tipName);
            return;
         }
         if(textInput.text.length == 0)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.NAME_NOT_NULL + "</font>";
         }
         else if(textInput.text.length < 2 || textInput.text.length > 6)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_LENGHT + "</font>";
         }
         else
         {
            if(!this.pattern.test(textInput.text))
            {
               infobtn.content.mouseEnabled = false;
               StrFilter.load(textInput.text,function(text:String):void
               {
                  var isShare:int = 0;
                  var len:int = 0;
                  var i:int = 0;
                  if(StrFilter.hasUnRegisterString(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + StrFilter.takeUnRegisterString(HtmlUtil.font(text,"#fe0000")) + "</font>";
                     infobtn.content.mouseEnabled = true;
                     setTip(tipName);
                     return;
                  }
                  if(strHd(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + "包含以下非法字符:" + HtmlUtil.font(getUnStr(text),"#fe0000") + "</font>";
                     infobtn.content.mouseEnabled = true;
                     setTip(tipName);
                     return;
                  }
                  isShare = 0;
                  len = int(cheVec.length);
                  i = 0;
                  while(i < len)
                  {
                     if(cheVec[i].selected)
                     {
                        isShare = 1;
                        break;
                     }
                     i++;
                  }
                  LoginCGMessage.CG_CREATE_ROLE(now.data[0],now.data[1],textInput.text,isShare);
               });
               this.setTip(tipName);
               return;
            }
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_COM + "</font>";
         }
         this.setTip(tipName);
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
      
      private function reset() : void
      {
         var i:int = 0;
         while(i < this.select_icon_arr.length)
         {
            this.select_icon_arr[i].visible = false;
            i++;
         }
      }
      
      public function show_tip(_index:int) : void
      {
         this.tip_maneger.update_tip(_index);
         this.tip_maneger.x = this.pos_arr[_index - 1][0];
         this.tip_maneger.y = this.pos_arr[_index - 1][1];
      }
      
      public function remove_tip(_index:int) : void
      {
         this.tip_maneger.visible = true;
         this.tip_maneger.remove_tip();
      }
      
      public function get_jop_title(_index:int) : void
      {
         this.jop_title.getIcon(_index);
      }
      
      public function remove_jop_title(_index:int) : void
      {
         this.jop_title.removeIcon();
      }
      
      public function select(icon:Icon) : void
      {
         this.chooAble = true;
         if(this.now == icon)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choo_sed = false;
         }
         this.reset();
         this.now = icon;
         this.now.choo_sed = true;
         this.setLightChoose(this.now);
         this.select_icon_arr[this.now.index].visible = true;
         if(!this.isChange)
         {
            this.changeName();
         }
         Global.stage.focus = textInput;
         textInput.setSelection(0,this.preName.length);
         this.carer = this.now.data[0];
      }
      
      private function getQQName() : void
      {
         if(Global.pf == "pengyou")
         {
            return;
         }
         var loadurl:String = "http://s2.app100621282.qqopenapp.com/get_info.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.setQQName);
         loader.load(url);
      }
      
      private function setQQName(e:Event) : void
      {
         var _parren:RegExp = /([^一-龥0-9A-Za-z])+/gi;
         Utils.print("QQname",e.target.data);
         var str:String = e.target.data;
         str = str.split(" ").join("");
         str = str.replace(_parren,"");
         if(str.length > 6)
         {
            str = str.substr(0,6);
         }
         textInput.text = str;
         if(textInput.text.length < 2 || textInput.text.length > 6)
         {
            this.selectName();
         }
      }
      
      public function dealShare() : void
      {
         var shareUrl:String = null;
         var pform:String = null;
         var encodeUrl:String = null;
         var loader:URLLoader = null;
         var url:URLRequest = null;
         Utils.print("dealShare");
         var len:int = int(this.cheVec.length);
         var i:int = 0;
         while(i < len)
         {
            if(this.cheVec[i].selected)
            {
               pform = this.cheVec[i].text;
               if(pform == this.TO_WEIBO)
               {
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=gamesendblog&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&discrpt=" + Model_initStr.YT_DISCRIPT + "&r=" + getTimer();
               }
               else if(pform == this.TO_QQGAME)
               {
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=setfeed&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&r=" + getTimer();
               }
               else if(pform == this.TO_QQPLUS)
               {
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=qplusshare&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&title=" + Model_initStr.YT_TITLE + "&summary=" + Model_initStr.YT_SUMMARY + "&comment=" + Model_initStr.YT_DISCRIPT + "&r=" + getTimer();
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
      
      override public function resize() : void
      {
         this.background.width = Global.stage.stageWidth;
         this.background.height = Global.stage.stageHeight;
         this.container2.x = (Global.stage.stageWidth - 1400) / 2;
         this.container2.y = (Global.stage.stageHeight - 700) / 2 + 50;
         this.container.x = (Global.stage.stageWidth - 1400) / 2;
         this.container.y = (Global.stage.stageHeight - 700) / 2 + 50;
      }
      
      override public function dispose() : void
      {
         var child:DisplayObject = null;
         super.dispose();
         while(Boolean(this.container.numChildren))
         {
            child = this.container.getChildAt(0);
            if(child is Bitmap)
            {
               (child as Bitmap).bitmapData.dispose();
            }
            if(child is Icon)
            {
               (child as Icon).dispose();
            }
            this.container.removeChild(child);
         }
         Global.createDm = null;
      }
      
      public function getRandomUserName(sex:int) : String
      {
         var firstName0:String = null;
         var firstName1:String = null;
         var lastName:String = this.FIRST_NAME[Utils.rnd(0,this.FIRST_NAME.length - 1)];
         if(sex == 1)
         {
            firstName0 = this.SEND_MAN_NAME_1[Utils.rnd(0,this.SEND_MAN_NAME_1.length - 1)];
            firstName1 = this.SEND_MAN_NAME_2[Utils.rnd(0,this.SEND_MAN_NAME_2.length - 1)];
         }
         else if(sex == 2)
         {
            firstName0 = this.SEND_WOMEN_NAME_1[Utils.rnd(0,this.SEND_WOMEN_NAME_1.length - 1)];
            firstName1 = this.SEND_WOMEN_NAME_2[Utils.rnd(0,this.SEND_WOMEN_NAME_2.length - 1)];
         }
         return lastName + firstName0 + firstName1;
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.model.Model_initStr;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

class Icon extends Sprite
{
   
   public var data:Array;
   
   public var image:Bitmap;
   
   public var url:String;
   
   public var _job_index:int;
   
   public var index:int;
   
   public var choosed:Boolean;
   
   private var OVER1_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER2_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER3_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER4_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var effect_arr:Array = [this.OVER1_EFFECT,this.OVER2_EFFECT,this.OVER3_EFFECT,this.OVER4_EFFECT];
   
   private var OUT_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.5,16776960,-255,-255,0);
   
   public function Icon(str:String, x:int, y:int, _data:Array)
   {
      super();
      this.url = String(int(str.charAt(0))) + String(int(str.charAt(1)));
      this.data = _data;
      this._job_index = int(str.charAt(0));
      buttonMode = true;
      this.image = ComponentUtil.getBitmap(this.url,this);
      addEventListener(MouseEvent.CLICK,this.clickEvent);
      filters = null;
      transform.colorTransform = Util.colorNomal;
      alpha = 0;
      this.x = x;
      this.y = y;
   }
   
   public function set choo_sed(value:Boolean) : void
   {
      this.choosed = value;
      if(!value)
      {
         alpha = 0;
         CreateScene.instance.remove_tip(this._job_index);
         CreateScene.instance.remove_jop_title(this._job_index);
      }
      else
      {
         filters = Util.glowFFFF00;
         cacheAsBitmap = true;
         cacheAsBitmap = true;
         transform.colorTransform = this.effect_arr[this._job_index - 1];
         CreateScene.instance.get_jop_title(this._job_index);
      }
   }
   
   public function get choo_sed() : Boolean
   {
      return this.choosed;
   }
   
   private function clickEvent(e:MouseEvent) : void
   {
      CreateScene.instance.select(this);
   }
   
   public function dispose() : void
   {
      if(Boolean(this.image.bitmapData))
      {
         this.image.bitmapData.dispose();
         delete Util.bmdPool[this.url];
      }
      removeEventListener(MouseEvent.CLICK,this.clickEvent);
   }
   
   public function get_job_tip(job_index:int) : void
   {
      CreateScene.instance.show_tip(job_index);
   }
   
   public function remove_job_tip(job_index:int) : void
   {
      CreateScene.instance.remove_tip(job_index);
   }
}

class Select_Icon extends Sprite
{
   
   public var data:Array;
   
   public var image:Bitmap;
   
   public var url:String;
   
   public function Select_Icon(str:String, x:int, y:int, _data:Array)
   {
      super();
      mouseChildren = false;
      mouseEnabled = false;
      this.url = String(int(str.charAt(0))) + String(int(str.charAt(1)));
      this.data = _data;
      this.image = ComponentUtil.getBitmap(this.url,this);
      buttonMode = true;
      this.x = x;
      this.y = y;
      visible = false;
   }
}

class TipHandle extends Sprite
{
   
   private var tf:MyTextField;
   
   private var back:DisplayObject;
   
   private var temBmpStr:String;
   
   private var str_arr:Array = Model_initStr.MENPAI;
   
   private var color_arr:Array = ["0xff0000","0x41eda1","0x66cc00","0xff00ff"];
   
   private var index:int;
   
   public function TipHandle()
   {
      super();
      this.back = ComponentUtil.getDisplayObject("Informat_Board",this);
      this.tf = ComponentUtil.getTextField("",this,{
         "x":9,
         "y":8
      });
      visible = false;
   }
   
   public function update_tip(_index:int) : void
   {
      visible = true;
      this.index = _index;
      this.tf.text = this.str_arr[_index - 1];
      this.tf.textColor = this.color_arr[_index - 1];
   }
   
   public function remove_tip() : void
   {
      visible = false;
   }
}

class GetJopTitle extends Sprite
{
   
   private var temBmpStr:String;
   
   private var image_jop:Bitmap;
   
   private var job_index:int;
   
   private var pos_arr:Array = [[323,161],[528,210],[726,270],[875,212]];
   
   public function GetJopTitle()
   {
      super();
      this.image_jop = new Bitmap();
      addChild(this.image_jop);
   }
   
   public function getIcon(_jop_index:int) : void
   {
      visible = true;
      if(Boolean(this.image_jop))
      {
         this.image_jop.bitmapData = null;
      }
      this.job_index = _jop_index;
      this.temBmpStr = "r" + _jop_index;
      this.image_jop.bitmapData = ComponentUtil.getBitmapData(this.temBmpStr,Global.createDm);
      this.x = this.pos_arr[_jop_index - 1][0];
      this.y = this.pos_arr[_jop_index - 1][1];
   }
   
   public function removeIcon() : void
   {
      this.image_jop.bitmapData = null;
      visible = false;
   }
}

class TipBack extends Sprite
{
   
   private var scaleBmp:ScaleBitmap;
   
   public function TipBack()
   {
      super();
      this.scaleBmp = ComponentUtil.getScaleBitmap("tipsBack",[6,20,1,1],this,{
         "width":140,
         "height":78
      },Global.createDm);
   }
   
   public function set setWidth(value:int) : void
   {
      this.scaleBmp.width = value;
   }
   
   public function set setHeight(value:int) : void
   {
      this.scaleBmp.height = value;
   }
}

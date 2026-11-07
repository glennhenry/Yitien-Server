package scene
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.RadioButton;
   import com.ui.controls.RadioButtonGroup;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
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
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.EffectManager;
   import manager.HtmlUtil;
   import manager.KeyBoardConst;
   import manager.MassLoader;
   import manager.StrFilter;
   import manager.Tween;
   import manager.Utils;
   import net.LoginCGMessage;
   import view.Effect;
   
   public class CreateScene extends IScene
   {
      
      private static var textFild:MyTextField;
      
      private static var tipsBg:TipBack;
      
      private static var _instance:CreateScene;
      
      private static var tipName:String = "";
      
      private static var UnWords:Array = [];
      
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
      
      private var bmPool:Dictionary = new Dictionary();
      
      private const ICON_POSITION:Array = [[445,156],[501,33],[772,187],[714,61]];
      
      private const BM_POSITION:Array = [[-2,-195],[66,-146],[31,-180],[40,-176],[28,-173],[58,-167],[34,-175],[81,-170]];
      
      private var container:Sprite = new Sprite();
      
      private var sexRadioBtnGroup:RadioButtonGroup;
      
      private var jobBms:Array;
      
      private var ranNameBtn:Button;
      
      private var textInput:TextField;
      
      private var enterBtn:Button;
      
      private var jobInfoBm:Bitmap;
      
      private var roleBm:Bitmap;
      
      private var roleEff:Effect;
      
      private var now:Icon;
      
      private var pattern:RegExp;
      
      private var roleName:String;
      
      private var isChange:Boolean = false;
      
      private var preName:String;
      
      private var carer:int;
      
      private var OVER1_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER2_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER3_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var OVER4_EFFECT:ColorTransform = new ColorTransform(1,1,1,1,255,1,1,1);
      
      private var effect_arr:Array = [this.OVER1_EFFECT,this.OVER2_EFFECT,this.OVER3_EFFECT,this.OVER4_EFFECT];
      
      private var chooAble:Boolean = false;
      
      private var curIndex:int;
      
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
         var loadurl:String = "http://s2.app100621282.qqopenapp.com/add_idol.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global.pf + "&r=" + getTimer();
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
         var male_rb:RadioButton;
         var female_rb:RadioButton;
         var textformat:TextFormat;
         var icon:Icon = null;
         var i:int = 0;
         var arr:Array = null;
         var _i:int = 0;
         var cheBox:CheckBox = null;
         super.show();
         this.cheContainer = new Sprite();
         this.cheContainer.x = 50;
         this.cheContainer.y = 30;
         if(Boolean(Global.pf))
         {
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isIwan(Global.pf))
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
         this.jobBms = [];
         i = 0;
         while(i < this.ICON_POSITION.length)
         {
            icon = new Icon(i);
            icon.x = this.ICON_POSITION[i][0];
            icon.y = this.ICON_POSITION[i][1];
            icon.addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
            icon.addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
            this.container.addChild(icon);
            this.jobBms.push(icon);
            i++;
         }
         this.sexRadioBtnGroup = new RadioButtonGroup();
         this.container.addChild(this.sexRadioBtnGroup);
         this.sexRadioBtnGroup.direction = RadioButtonGroup.HORIZONTAL;
         this.sexRadioBtnGroup.x = 597;
         this.sexRadioBtnGroup.y = 463;
         this.sexRadioBtnGroup.space = 90;
         male_rb = ComponentUtil.getRadioButton("","sexSel",this.sexRadioBtnGroup,{"value":1});
         female_rb = ComponentUtil.getRadioButton("","sexSel",this.sexRadioBtnGroup,{"value":2});
         this.sexRadioBtnGroup.selectedItem = Util.rnd(0,1) == 0 ? male_rb : female_rb;
         this.sexRadioBtnGroup.addEventListener(RadioButtonGroup.SELECTED_CHANGE,this.sexSel);
         this.ranNameBtn = ComponentUtil.getButton("","Button_Dice",this.container,{
            "x":770,
            "y":496
         });
         this.ranNameBtn.addEventListener(MouseEvent.CLICK,this.ranNameHandle);
         this.enterBtn = ComponentUtil.getButton("","enterBtn",this.container,{
            "x":587,
            "y":529
         });
         this.enterBtn.addEventListener(MouseEvent.CLICK,this.enterGame);
         this.jobInfoBm = new Bitmap();
         this.jobInfoBm.x = 80;
         this.jobInfoBm.y = 51;
         this.container.addChild(this.jobInfoBm);
         this.roleBm = new Bitmap();
         this.container.addChild(this.roleBm);
         this.pattern = /([^一-龥0-9A-Za-z])+/;
         textFild = ComponentUtil.getTextField("",null,{
            "multiline":true,
            "wordWrap":true,
            "leading":5,
            "color":10944511,
            "bold":true,
            "y":16,
            "x":2,
            "realWidth":140
         });
         textFild.autoSize = TextFieldAutoSize.CENTER;
         tipsBg = new TipBack();
         tipsBg.addChild(textFild);
         tipsBg.x = 440;
         tipsBg.y = 515;
         this.container.addChild(tipsBg);
         tipName = "<td><nobr><font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + "" + "</font></nobr></td>";
         this.setTip(tipName);
         this.FIRST_NAME = Model_initStr.FIRST_NAME;
         this.SEND_MAN_NAME_1 = Model_initStr.SEND_MAN_NAME_1;
         this.SEND_MAN_NAME_2 = Model_initStr.SEND_MAN_NAME_2;
         this.SEND_WOMEN_NAME_1 = Model_initStr.SEND_WOMEN_NAME_1;
         this.SEND_WOMEN_NAME_2 = Model_initStr.SEND_WOMEN_NAME_2;
         this.textInput = ComponentUtil.getTextField(this.getRandomUserName(1 + int(Math.random() * 2)),null,{
            "size":14,
            "realWidth":150,
            "height":30,
            "width":150,
            "y":498,
            "maxChars":6,
            "type":TextFieldType.INPUT,
            "multiline":false,
            "wordWrap":false
         });
         this.container.addChild(this.textInput);
         textformat = new TextFormat();
         textformat.align = "center";
         this.textInput.defaultTextFormat = textformat;
         this.preName = this.textInput.text;
         this.textInput.x = 590;
         this.textInput.doubleClickEnabled = true;
         Global.stage.focus = this.textInput;
         this.textInput.addEventListener(MouseEvent.DOUBLE_CLICK,function():void
         {
            textInput.setSelection(0,textInput.text.length);
         });
         this.textInput.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void
         {
            if(e.keyCode == KeyBoardConst.ENTER)
            {
               enterGame(new MouseEvent(MouseEvent.CLICK));
            }
         });
         this.textInput.addEventListener(Event.CHANGE,function(e:Event):void
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
         this.textInput.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
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
         this.textInput.text = "";
         addChild(this.container);
         addChild(this.cheContainer);
         this.carer = Util.rnd(0,3);
         this.select(this.jobBms[this.carer]);
         this.selectName();
         this.getQQName();
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         var tem_icon:Icon = e.target as Icon;
         if(this.now == tem_icon)
         {
            return;
         }
         tem_icon.alpha = 1;
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         var tem_icon:Icon = e.target as Icon;
         if(tem_icon == this.now)
         {
            return;
         }
         tem_icon.alpha = 0;
      }
      
      private function setLightChoose(instance_icon:Icon) : void
      {
         instance_icon.alpha = 1;
      }
      
      private function ranNameHandle(e:MouseEvent) : void
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
         if(this.preName == this.textInput.text)
         {
            this.selectName();
            this.preName = this.textInput.text;
         }
         this.selectName();
      }
      
      private function selectName() : void
      {
         if(int(this.sexRadioBtnGroup.selectedItem.value) == 1)
         {
            this.roleName = this.getRandomUserName(1);
         }
         else
         {
            this.roleName = this.getRandomUserName(2);
         }
         this.textInput.text = this.roleName;
         Global.stage.focus = this.textInput;
         this.textInput.setSelection(0,this.preName.length);
         tipName = "<td><nobr><font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.DEFAULT_NAME + "</font></nobr></td>";
         this.setTip(tipName);
      }
      
      private function setTip(tipName:String) : void
      {
         textFild.width = 131;
         textFild.htmlText = tipName;
         tipsBg.setWidth = textFild.width + 30;
         tipsBg.setHeight = textFild.height + 24;
      }
      
      public function nameRepeat() : void
      {
         this.setTip(Model_initStr.CHONGFU_NAME);
         this.enterBtn.mouseEnabled = true;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         this.selectName();
         this.preName = this.textInput.text;
         Global.stage.focus = this.textInput;
         this.textInput.setSelection(0,this.preName.length);
      }
      
      private function enterGame(e:MouseEvent) : void
      {
         if(!this.enterBtn.mouseEnabled)
         {
            return;
         }
         this.enterBtn.mouseEnabled = true;
         if(!this.chooAble && Boolean(this.textInput.text.length))
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.CHOOSE_ONE_HERO + "</font>";
            this.setTip(tipName);
            return;
         }
         if(this.textInput.text.length == 0)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(29) + "\'>" + Model_initStr.NAME_NOT_NULL + "</font>";
         }
         else if(this.textInput.text.length < 2 || this.textInput.text.length > 6)
         {
            tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + Model_initStr.NAME_LENGHT + "</font>";
         }
         else
         {
            if(!this.pattern.test(this.textInput.text))
            {
               this.enterBtn.mouseEnabled = false;
               StrFilter.load(this.textInput.text,function(text:String):void
               {
                  var isShare:int = 0;
                  var isShouTing:int = 0;
                  var len:int = 0;
                  var i:int = 0;
                  if(StrFilter.hasUnRegisterString(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + StrFilter.takeUnRegisterString(HtmlUtil.font(text,"#fe0000")) + "</font>";
                     enterBtn.mouseEnabled = true;
                     setTip(tipName);
                     return;
                  }
                  if(strHd(text))
                  {
                     tipName = "<font size=\'12pt\' color=\'" + ColorConstant.getColorStr(2) + "\'>" + "包含以下非法字符:" + HtmlUtil.font(getUnStr(text),"#fe0000") + "</font>";
                     enterBtn.mouseEnabled = true;
                     setTip(tipName);
                     return;
                  }
                  isShare = 0;
                  isShouTing = 0;
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
                  LoginCGMessage.CG_CREATE_ROLE(now.index + 1,int(sexRadioBtnGroup.selectedItem.value),textInput.text,isShare,isShouTing);
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
         while(i < this.jobBms.length)
         {
            this.jobBms[i].alpha = 0;
            i++;
         }
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
         this.now = icon;
         this.now.choo_sed = true;
         this.setLightChoose(this.now);
         this.setRoleBm();
         this.carer = this.now.index + 1;
         this.jobInfoBm.alpha = 0;
         var url:String = "resource/image/create/m" + this.carer + ".jpg";
         if(Boolean(this.bmPool[url]))
         {
            this.jobInfoBm.bitmapData = this.bmPool[url] as BitmapData;
            Tween.to(this.jobInfoBm,700,{"alpha":[0.3,1]});
         }
         else
         {
            MassLoader.add(url,this.jobInfoBmComp,null,MassLoader.LEVEL2,{"bm":this.jobInfoBm});
         }
      }
      
      private function jobInfoBmComp(info:Object) : void
      {
         this.bmPool[info.url] = (info.content as Bitmap).bitmapData;
         if("resource/image/create/m" + this.carer + ".jpg" == info.url)
         {
            this.jobInfoBm.bitmapData = (info.content as Bitmap).bitmapData;
            Tween.to(this.jobInfoBm,800,{"alpha":[0.3,1]});
         }
      }
      
      private function sexSel(e:Event) : void
      {
         this.changeName();
         this.setRoleBm();
      }
      
      private function setRoleBm() : void
      {
         this.roleBm.alpha = 0;
         this.curIndex = this.now.index * 2 + int(this.sexRadioBtnGroup.selectedItem.value);
         var url:String = "resource/image/create/" + this.curIndex + ".swf";
         if(Boolean(this.bmPool[url]))
         {
            this.roleBm.bitmapData = this.bmPool[url] as BitmapData;
            this.showRoleBmFly();
         }
         else
         {
            MassLoader.add(url,this.roleBmComp,null,MassLoader.LEVEL0,{"bm":this.roleBm});
         }
      }
      
      private function roleBmComp(info:Object) : void
      {
         var bmd:BitmapData = ComponentUtil.getBitmapData("s",info.applicationDomain);
         this.bmPool[info.url] = bmd;
         if("resource/image/create/" + this.curIndex + ".swf" == info.url)
         {
            this.roleBm.bitmapData = bmd;
            this.showRoleBmFly();
         }
      }
      
      private function showRoleBmFly() : void
      {
         this.roleBm.x = this.BM_POSITION[this.curIndex - 1][0] + 512;
         this.roleBm.y = this.BM_POSITION[this.curIndex - 1][1] + 50;
         Tween.to(this.roleBm,250,{
            "alpha":[0.4,1],
            "y":[this.BM_POSITION[this.curIndex - 1][1] + 50,this.BM_POSITION[this.curIndex - 1][1] + 290]
         },function():void
         {
         },null,Tween.SIN);
      }
      
      private function getQQName() : void
      {
         if(Global.pf == "pengyou")
         {
            return;
         }
         var loadurl:String = "http://s2.app100621282.qqopenapp.com/get_info.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global.pf + "&r=" + getTimer();
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
         this.textInput.text = str;
         if(this.textInput.text.length < 2 || this.textInput.text.length > 6)
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
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=gamesendblog&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&discrpt=" + Model_initStr.YT_DISCRIPT + "&r=" + getTimer();
               }
               else if(pform == this.TO_QQGAME)
               {
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=setfeed&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&r=" + getTimer();
               }
               else if(pform == this.TO_QQPLUS)
               {
                  shareUrl = "http://s2.app100621282.qqopenapp.com/interface.php?op=qplusshare&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=" + Global.pf + "&title=" + Model_initStr.YT_TITLE + "&summary=" + Model_initStr.YT_SUMMARY + "&comment=" + Model_initStr.YT_DISCRIPT + "&r=" + getTimer();
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
         this.cheContainer.x = (Global.stage.stageWidth - 1024) / 2;
         this.cheContainer.y = (Global.stage.stageHeight - 580) / 2;
         this.container.x = (Global.stage.stageWidth - 1024) / 2;
         this.container.y = (Global.stage.stageHeight - 580) / 2;
      }
      
      override public function dispose() : void
      {
         var bmdUrl:String = null;
         var child:DisplayObject = null;
         super.dispose();
         if(Boolean(this.roleEff))
         {
            EffectManager.removeEffect(this.roleEff);
            this.roleEff = null;
         }
         for(bmdUrl in this.bmPool)
         {
            this.bmPool[bmdUrl].dispose();
            delete this.bmPool[bmdUrl];
         }
         while(Boolean(this.container.numChildren))
         {
            child = this.container.getChildAt(0);
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

import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.utils.Util;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import scene.CreateScene;

class Icon extends Sprite
{
   
   private var image:Bitmap;
   
   public var index:int;
   
   public var choosed:Boolean;
   
   private var OVER1_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER2_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER3_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var OVER4_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.7,255,1,1,0.7);
   
   private var effect_arr:Array = [this.OVER1_EFFECT,this.OVER2_EFFECT,this.OVER3_EFFECT,this.OVER4_EFFECT];
   
   private var OUT_EFFECT:ColorTransform = new ColorTransform(1,1,1,0.5,16776960,-255,-255,0);
   
   public function Icon(_index:int)
   {
      super();
      this.index = _index;
      buttonMode = true;
      this.image = ComponentUtil.getBitmap("m" + (this.index + 1),this);
      addEventListener(MouseEvent.CLICK,this.clickEvent);
      filters = null;
      transform.colorTransform = Util.colorNomal;
      alpha = 0;
   }
   
   public function set choo_sed(value:Boolean) : void
   {
      this.choosed = value;
      if(!value)
      {
         alpha = 0;
      }
      else
      {
         alpha = 1;
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
      removeEventListener(MouseEvent.CLICK,this.clickEvent);
   }
}

class TipBack extends Sprite
{
   
   private var scaleBmp:ScaleBitmap;
   
   public function TipBack()
   {
      super();
      this.scaleBmp = ComponentUtil.getScaleBitmap("tipsBack",[5,24,3,3],this,{
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

package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_qqHuiyuan extends Sprite
   {
      
      public static var _instance:View_qqHuiyuan;
      
      private static var txtDescrip:Array;
      
      private static var isInit:Boolean = false;
      
      private static var isFirstOpen:Boolean = true;
      
      private static const ssTimeReplay:String = "2013年2月16至2013年2月22日";
      
      private static var isOn:Boolean = false;
      
      private var btnK:Button;
      
      private var btnX:Button;
      
      private var btnMain:MainUIBtn;
      
      private var posArr:Array = [[72,105],[283,105],[278,137],[70,299]];
      
      private var widthArr:Array = [178,158.2,223.2,409.2];
      
      private var sizeArr:Array = [14,16,14,14];
      
      private var vo:Vo_item;
      
      private var _id:int;
      
      public function View_qqHuiyuan()
      {
         super();
      }
      
      public static function get instance() : View_qqHuiyuan
      {
         if(Boolean(_instance))
         {
            return _instance;
         }
         _instance = new View_qqHuiyuan();
         return _instance;
      }
      
      public function init() : void
      {
         this.visible = true;
         if(isInit)
         {
            return;
         }
         isInit = true;
         GameScene.uiLayer.addChild(this);
         this.move = new Rectangle(0,0,547,38);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               SingleLoader.add("lang/ch/Diamond_Imgs.swf",function(info:Object):void
               {
                  Global.Diamond_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            Tween.to(this,300,{
               "alpha":[0,1],
               "x":[(Global.stage.stageWidth - 548) / 2 + 20,(Global.stage.stageWidth - 548) / 2]
            });
         }
      }
      
      public function set move(rect:Rectangle) : void
      {
         var spr:Sprite = new Sprite();
         addChild(spr);
         spr.graphics.beginFill(0,0);
         spr.graphics.drawRect(0,0,rect.width,rect.height);
         spr.graphics.endFill();
         spr.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void
         {
            startDrag();
         });
         spr.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
         {
            stopDrag();
         });
      }
      
      private function resetPos() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function showBmp() : void
      {
         var i:int;
         var btnClose:Button;
         var shp:Sprite;
         var str1:String = null;
         var str2:String = null;
         var strDes:String = null;
         var tf:MyTextField = null;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":0,
            "y":0,
            "width":548,
            "height":443
         },Global.Img_Cdm);
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            ComponentUtil.getBitmap("BG_HuiYuan",this,{
               "x":10,
               "y":10
            },Global.Diamond_Imgsdm);
            strDes = "会员";
            this._id = 46939;
            if(Boolean(GameUnitManager.hero.isHuiyuan))
            {
               str1 = "Button_VIPXF";
               str2 = "Button_VIPXFNF";
            }
            else
            {
               str1 = "Button_VIPKT";
               str2 = "Button_VIPKTNF";
            }
         }
         else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
         {
            ComponentUtil.getBitmap("BG_LanZuan",this,{
               "x":10,
               "y":10
            },Global.Diamond_Imgsdm);
            strDes = "蓝钻";
            this._id = 46460;
            if(Boolean(GameUnitManager.hero.isHuiyuan))
            {
               str1 = "Button_BuleXF";
               str2 = "Button_BuleXFNF";
            }
            else
            {
               str1 = "Button_BuleKT";
               str2 = "Button_BuleKTNF";
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            ComponentUtil.getBitmap("BG_HuangZuan",this,{
               "x":10,
               "y":10
            },Global.Diamond_Imgsdm);
            strDes = "黄钻";
            this._id = 46418;
            if(Boolean(GameUnitManager.hero.isHuiyuan))
            {
               str1 = "Button_YellowXF";
               str2 = "Button_YellowXFNF";
            }
            else
            {
               str1 = "Button_YellowKT";
               str2 = "Button_YellowKTNF";
            }
         }
         this.btnK = ComponentUtil.getButton("",str1,this,{
            "x":87,
            "y":378,
            "textColor":16184781
         },Global.Diamond_Imgsdm);
         this.btnX = ComponentUtil.getButton("",str2,this,{
            "x":271,
            "y":378,
            "textColor":16184781
         },Global.Diamond_Imgsdm);
         ComponentUtil.getBitmap("Gift_Bag",this,{
            "x":88,
            "y":165
         },Global.Diamond_Imgsdm);
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            txtDescrip = ["" + LangConfig.getWord("998",0),LangConfig.getWord("999",0,strDes),Model_txAction.huiYuanStr + HtmlUtil.font(HtmlUtil.font("领取条件：","#04ff00",14) + "\n    每个角色仅可通过" + HtmlUtil.font("开通或续费","#fe0000",14) + "会员获得" + HtmlUtil.font("一个","#fe0000",14) + "礼包，多次开通或续费无法获得多个礼包。","#f4cd31",14),"     " + LangConfig.getWord("1157",0,strDes,strDes).replace(ssTimeReplay,Global.guanWangTimeCrl)];
         }
         else
         {
            txtDescrip = ["" + LangConfig.getWord("998",0),LangConfig.getWord("999",0,strDes),LangConfig.getWord("1000",0,strDes,strDes),"     " + LangConfig.getWord("1001",0,strDes,strDes)];
         }
         i = 0;
         while(i < 4)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":this.posArr[i][0],
               "y":this.posArr[i][1],
               "realWidth":this.widthArr[i],
               "size":this.sizeArr[i]
            });
            tf.multiline = true;
            tf.wordWrap = true;
            tf.htmlText = txtDescrip[i];
            i++;
         }
         btnClose = ComponentUtil.getButton("","Button_HDClose",this,{
            "x":517,
            "y":11
         });
         btnClose.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            visible = false;
         });
         this.btnK.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         });
         this.btnX.addEventListener(MouseEvent.CLICK,function():void
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         });
         shp = new Sprite();
         shp.graphics.beginFill(0,0);
         shp.graphics.drawRect(120,165,65,73);
         shp.graphics.endFill();
         addChild(shp);
         shp.addEventListener(MouseEvent.MOUSE_OVER,this.showTip);
         shp.addEventListener(MouseEvent.MOUSE_OUT,this.hideTip);
         shp.addEventListener(MouseEvent.MOUSE_MOVE,this.moveOn);
         this.resetPos();
      }
      
      private function moveOn(e:MouseEvent) : void
      {
         if(isOn)
         {
            TipManager.view_tip.x = Global.stage.mouseX;
            TipManager.view_tip.y = Global.stage.mouseY;
         }
      }
      
      private function showTip(e:MouseEvent) : void
      {
         isOn = true;
         if(!this.vo)
         {
            this.vo = new Vo_item();
            this.vo.id = this._id;
            this.vo.Init_lib();
         }
         TipManager.update(this.vo);
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
      
      private function hideTip(e:MouseEvent) : void
      {
         isOn = false;
         TipManager.hide();
      }
      
      public function show() : void
      {
         var strIcon:String = null;
         if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            strIcon = "hongZuan";
         }
         else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366)
         {
            strIcon = "lan";
         }
         else
         {
            if(!(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf)))
            {
               return;
            }
            strIcon = "huang";
         }
         if(!this.btnMain)
         {
            this.btnMain = new MainUIBtn("resource/image/Diamond/" + strIcon + ".png");
         }
         if(!this.btnMain.hasEventListener(MouseEvent.CLICK))
         {
            this.btnMain.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var pan:View_hzTribute = null;
               if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366 || Enum_SPStr.isIwan(Global.pf))
               {
                  pan = Singleton.getInstance(View_hzTribute) as View_hzTribute;
                  (Singleton.getInstance(Delegate123) as Delegate123).dosomething(pan,function():void
                  {
                     pan.show();
                  });
               }
               else if(Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
               {
                  YelloDiaCGMessage.CG_OPEN_HONGZUAN();
               }
            });
         }
         if(!UIManager.mainUiBtnContainer.hasBTN(this.btnMain))
         {
            UIManager.mainUiBtnContainer.addBTN(this.btnMain);
         }
      }
      
      public function remove() : void
      {
         if(Boolean(this.btnMain) && UIManager.mainUiBtnContainer.hasBTN(this.btnMain))
         {
            UIManager.mainUiBtnContainer.removeBTN(this.btnMain);
         }
      }
   }
}


package com.yiTian.view.modules.chongzhi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.FundCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import com.yiTian.view.modules.yellowDiamond.Model_txAction;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   
   public class View_YuanBaoXiang extends Panel
   {
      
      private const sendData:Array = [{
         "id":0,
         "count":0
      },{
         "id":1,
         "count":2
      },{
         "id":2,
         "count":5
      },{
         "id":3,
         "count":12
      }];
      
      private var mmBm:Bitmap;
      
      private var btn:Button;
      
      private var goldTF:MyTextField;
      
      private var silverTF:MyTextField;
      
      private var copperTF:MyTextField;
      
      private var rangY:int;
      
      private var _isInitData:Boolean;
      
      private var _ybitems:Array;
      
      public var isNeedAutoOpenCZ:Boolean;
      
      private var isFirstOpen:Boolean = true;
      
      public function View_YuanBaoXiang()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var st:String = null;
         var content:MyTextField = null;
         var pf:String = Global.pf;
         if(pf == Enum_SPStr.QZONE || pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
         {
            this.rangY = 35;
         }
         else
         {
            this.rangY = 0;
         }
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":562,
            "height":414 + this.rangY
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":514,
            "height":364 + this.rangY
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":301,
            "y":240 + this.rangY,
            "width":82,
            "height":82
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":57,
            "y":240 + this.rangY,
            "width":82,
            "height":82
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":179,
            "y":240 + this.rangY,
            "width":82,
            "height":82
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this,{
            "x":423,
            "y":240 + this.rangY,
            "width":82,
            "height":82
         },Global.Img_Cdm);
         if(pf == Enum_SPStr.QZONE || pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
         {
            content = ComponentUtil.getTextField("",this,{
               "x":55,
               "y":220
            });
            content.multiline = true;
            content.htmlText = LangConfig.getWord("80057",8);
            this.goldTF = ComponentUtil.getTextField(LangConfig.getWord("80058",8),this,{
               "x":95,
               "y":234,
               "color":16776960
            },"center");
            this.silverTF = ComponentUtil.getTextField(LangConfig.getWord("80059",8),this,{
               "x":186,
               "y":234,
               "color":16776960
            },"center");
            this.copperTF = ComponentUtil.getTextField(LangConfig.getWord("80060",8),this,{
               "x":283,
               "y":234,
               "color":16776960
            },"center");
         }
         move = new Rectangle(0,0,562,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":528,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            st = "openBlueBtn";
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            st = "Button_KTHuiYuan";
         }
         else
         {
            st = "Button_HuangZhuan";
         }
         this.btn = ComponentUtil.getButton("",st,this,{
            "x":301,
            "y":55
         },ComponentUtil.domain);
         this.btn.addEventListener(MouseEvent.CLICK,this.linkToYellowDia);
         if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            this.btn.visible = false;
         }
      }
      
      public function updata(goldNum:int, silverNum:int, copperNum:int) : void
      {
         this.goldTF.text = LangConfig.getWord("80058",8) + goldNum;
         this.silverTF.text = LangConfig.getWord("80059",8) + silverNum;
         this.copperTF.text = LangConfig.getWord("80060",8) + copperNum;
      }
      
      private function getZKQdata() : void
      {
         var loadurl:String = "http://s2.app100621282.qqopenapp.com/interface.php?op=discount&openid=" + Global.account + "&pfkey=" + Global.fpkey + "&openkey=" + Global.openkey + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.load_ZKQ_comp);
         loader.load(url);
      }
      
      private function load_ZKQ_comp(e:Event) : void
      {
         var data:Array = e.target.data.split("|");
         if(Boolean(data))
         {
            this.updata(data[0],data[1],data[2]);
         }
      }
      
      private function loadInfo() : void
      {
         var st:String = null;
         var titleBm:Bitmap = new Bitmap();
         Utils.loadTitle("lang/ch/ChongZhi_Imgs.swf","Title_ChongZhi",titleBm,{
            "x":201,
            "y":5
         },this);
         var backspr:Sprite = new Sprite();
         addChild(backspr);
         backspr.buttonMode = true;
         backspr.addEventListener(MouseEvent.CLICK,this.linkToYellowDia);
         if(Global.pf == "qqgame" || Global.pf == "3366")
         {
            st = "back2";
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            st = "back3";
            backspr.mouseEnabled = false;
            backspr.buttonMode = false;
         }
         else
         {
            st = "back";
         }
         this.mmBm = Utils.getLoadBitmap("resource/image/chongzhi/" + st + ".jpg",this.mmBm,{
            "x":28,
            "y":43
         });
         backspr.addChild(this.mmBm);
         setChildIndex(this.btn,numChildren - 1);
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest("http://token.app100621282.twsapp.com/goodsprice.php");
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.loaded);
         loader.load(url);
      }
      
      private function linkToYellowDia(e:MouseEvent) : void
      {
         if(Global.pf == "qqgame")
         {
            ExternalInterface.call("minipayOpenVIP");
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG)
         {
            navigateToURL(new URLRequest("http://pay.qq.com/qqvip/index2.0.shtml?aid=vip.youxi.webgame.YT.qplus"));
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
         {
            navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100621282.yop&paytime=year"));
         }
         else if(Global.pf == Enum_SPStr.QQ3366)
         {
            navigateToURL(new URLRequest(Model_txAction.QQ3366_URL));
         }
      }
      
      private function loaded(e:Event) : void
      {
         var datas:Array = [];
         var teapItems:Array = (e.target.data as String).split("|");
         var len:int = int(teapItems.length);
         var i:int = 0;
         while(i < len)
         {
            datas.push(teapItems[i].split("_"));
            i++;
         }
         this.update(datas);
      }
      
      private function update(datas:Array) : void
      {
         var ybitem:YuanBXItem = null;
         var item:Vo_item = null;
         var i:int = 0;
         this._ybitems = [];
         var len:int = int(datas.length);
         i = 0;
         while(i < len)
         {
            ybitem = new YuanBXItem();
            ybitem.x = 57 + i * 122;
            ybitem.y = 235 + this.rangY;
            item = new Vo_item();
            item.id = datas[i][0];
            item.Init_lib();
            item.price = datas[i][1];
            ybitem.update(item,this.sendData[i]);
            addChild(ybitem);
            this._ybitems.push(ybitem);
            i++;
         }
         this._isInitData = true;
         this.openCZ();
      }
      
      public function openCZ() : void
      {
         if(!this._ybitems)
         {
            return;
         }
         if(!this.isNeedAutoOpenCZ)
         {
            return;
         }
         YuanBXItem(this._ybitems[0]).buyHandle();
         this.isNeedAutoOpenCZ = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(!this._isInitData && value)
         {
            this.loadInfo();
         }
         if(value)
         {
            FundMter.isOpenChongZhi = true;
            FundCGMessage.CG_FUND_RECHARGE();
            if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
            {
               this.getZKQdata();
            }
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_CHONGZHI);
            }
         }
      }
   }
}


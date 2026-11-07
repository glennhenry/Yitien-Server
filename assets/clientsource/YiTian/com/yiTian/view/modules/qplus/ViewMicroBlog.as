package com.yiTian.view.modules.qplus
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.QplusShareCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   
   public class ViewMicroBlog extends Sprite
   {
      
      public static var instance:ViewMicroBlog;
      
      private var rewardItemArr:Array = new Array();
      
      private var zoneBtn:Button;
      
      private var microBtn:Button;
      
      private var careBtn:Button;
      
      private var getBtn:Button;
      
      private var stateArr:Array = new Array();
      
      private var btnArr:Array = new Array();
      
      private var giftArr:Array = [46403,46617,46063];
      
      private var focusSpr:Sprite;
      
      private var isListenOrCare:int;
      
      private var isFirstListen:Boolean = false;
      
      private var isFirstCare:Boolean = false;
      
      private var shareOutUrl:String = "http://app100621282.imgcache.qzoneapp.com/app100621282/qqshare/qqshare_1207-";
      
      private var curTime:int;
      
      private var recTime:String;
      
      private var lastTime:int;
      
      public function ViewMicroBlog()
      {
         super();
         this.init();
         instance = this;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var bm:Bitmap = null;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":456,
            "height":344
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":2,
            "width":452,
            "height":60
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":2,
            "y":61,
            "width":315,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":319,
            "y":61,
            "width":135,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":3,
            "y":61,
            "width":213,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("30110",3),this,{
            "x":73,
            "y":18,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("30111",3),this,{
            "x":243,
            "y":65,
            "color":16764206,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < 3)
         {
            grid = new View_Grid(true);
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
            grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
            addChild(grid);
            this.rewardItemArr.push(grid);
            grid.x = 230;
            grid.y = 89 + i * 80;
            vo = new Vo_item();
            vo.id = this.giftArr[i];
            vo.Init_lib();
            grid.vo = vo;
            i++;
         }
         this.focusSpr = new Sprite();
         this.addChild(this.focusSpr);
         this.focusSpr.buttonMode = true;
         bm = new Bitmap();
         bm.x = 2;
         bm.y = 61;
         this.focusSpr.addChild(bm);
         Utils.getSwfBitmap(Global.jiaodianUrl,bm);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":354,
            "y":107
         },Global.FengXiang_Imgsdm);
         var ss1:String = "";
         var ss2:String = "";
         var ss3:String = "";
         if(Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.QQGAME)
         {
            ss1 = "No1_Zone";
            ss2 = "No2_WB";
            ss3 = "No3_KJ";
         }
         else
         {
            ss1 = "qqBtn1C";
            ss2 = "qqBtn1D";
            ss3 = "qqBtn1E";
         }
         this.zoneBtn = ComponentUtil.getButton("",ss1,this,{
            "x":327,
            "y":66
         },Global.FengXiang_Imgsdm);
         this.btnArr.push(this.zoneBtn);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":334,
            "y":161
         },Global.FengXiang_Imgsdm);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":354,
            "y":183
         },Global.FengXiang_Imgsdm);
         this.microBtn = ComponentUtil.getButton("",ss2,this,{
            "x":327,
            "y":142
         },Global.FengXiang_Imgsdm);
         this.btnArr.push(this.microBtn);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":354,
            "y":259
         },Global.FengXiang_Imgsdm);
         this.careBtn = ComponentUtil.getButton("",ss3,this,{
            "x":327,
            "y":218
         },Global.FengXiang_Imgsdm);
         this.btnArr.push(this.careBtn);
         this.getBtn = ComponentUtil.getButton("","LingQu",this,{
            "x":338,
            "y":295,
            "textColor":16771436
         },Global.FengXiang_Imgsdm);
         this.btnArr.push(this.getBtn);
         this.focusSpr.addEventListener(MouseEvent.CLICK,this.focusHandle);
         this.zoneBtn.addEventListener(MouseEvent.CLICK,this.zoneHandle);
         this.microBtn.addEventListener(MouseEvent.CLICK,this.microHandle);
         this.careBtn.addEventListener(MouseEvent.CLICK,this.careHandle);
         this.getBtn.addEventListener(MouseEvent.CLICK,this.getHandle);
      }
      
      private function focusHandle(evt:MouseEvent) : void
      {
         var reNet:URLRequest = new URLRequest(Global.jiaodianLinkUrl);
         navigateToURL(reNet);
      }
      
      private function zoneHandle(evt:MouseEvent) : void
      {
         var _shareTitle:String = null;
         var _shareContent:String = null;
         var _shareOutUrl:String = null;
         if(Global.pf != Enum_SPStr.QQGAME)
         {
            _shareTitle = "倚天不出，谁与争锋！";
            _shareContent = "关注倚天成时尚，焦点倚天我自豪。我在琳琅满目的选择中关注了倚天官方微博";
            _shareOutUrl = this.shareOutUrl + 21 + ".jpg";
            ExternalInterface.call("share",encodeURI(LangConfig.getWord("29191",2)),encodeURI(_shareTitle),encodeURI(_shareContent),_shareOutUrl);
         }
         QplusShareCGMessage.CG_BLOG_STEP(1);
      }
      
      private function microHandle(evt:MouseEvent) : void
      {
         if(this.stateArr[0] == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30112",3));
            return;
         }
         this.isToMicro();
         this.isListenOrCare = 1;
         this.isFirstListen = false;
         GameScene.instance.addFrameCallBack(this.runTime);
      }
      
      private function runTime() : void
      {
         if(getTimer() - this.lastTime >= 2000)
         {
            this.lastTime = getTimer();
            if(this.isListenOrCare == 1)
            {
               this.isToMicro();
               trace("isToMicro");
            }
            else if(this.isListenOrCare == 2)
            {
               this.loadZoneUrl();
               trace("loadZoneUrl");
            }
         }
      }
      
      private function isToMicro() : void
      {
         var loadUrl:String = "http://api1.app100621282.twsapp.com/openapi.php?mod=user&op=isfansoridol&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=tapp&names=yitian_tx&flag=2&r=" + getTimer();
         Utils.print(loadUrl);
         var load:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadUrl);
         url.method = URLRequestMethod.GET;
         load.dataFormat = URLLoaderDataFormat.TEXT;
         load.addEventListener(Event.COMPLETE,this.loadMicro);
         load.load(url);
      }
      
      private function loadMicro(e:Event) : void
      {
         Utils.print(e.target.data + "收听倚天官方微博。");
         var result:Array = (e.target.data as String).split("_");
         if(result.length >= 0 && result[3] != null)
         {
            if(int(result[3]) == 1)
            {
               UIManager.centerBroadcast.addMsg("已经成功收听《倚天》官方微博。");
               QplusShareCGMessage.CG_BLOG_STEP(2);
               if(GameScene.instance.hasFrameCallBack(this.runTime))
               {
                  GameScene.instance.removeFrameCallBack(this.runTime);
               }
            }
            else if(!this.isFirstListen)
            {
               this.isFirstListen = true;
               this.linkToMicro();
            }
         }
         else if(!this.isFirstListen)
         {
            this.isFirstListen = true;
            this.linkToMicro();
         }
      }
      
      private function linkToMicro() : void
      {
         var reNet:URLRequest = new URLRequest("http://e.t.qq.com/yitian_tx");
         navigateToURL(reNet);
      }
      
      private function listenToMicro() : void
      {
         QQShare.instance.setFrameCoord(this.localToGlobal(new Point(this.careBtn.x - 25,this.careBtn.y - 22)));
         QQShare.instance.visible = true;
         QplusShareCGMessage.CG_BLOG_STEP(2);
      }
      
      private function careHandle(evt:MouseEvent) : void
      {
         if(this.stateArr[1] == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30113",3));
            return;
         }
         QQShare.instance.visible = false;
         this.loadZoneUrl();
         this.isListenOrCare = 2;
         this.isFirstCare = false;
         GameScene.instance.addFrameCallBack(this.runTime);
      }
      
      private function loadZoneUrl() : void
      {
         var loadurl:String = "http://api1.app100621282.twsapp.com/openapi.php?mod=user&op=isfans&openid=" + Global.account + "&openkey=" + Global.openkey + "&pf=qzone&page_id=2202410325&r=" + getTimer();
         Utils.print(loadurl);
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.loaded);
         loader.load(url);
      }
      
      private function loaded(e:Event) : void
      {
         var url:String = null;
         var reNet:URLRequest = null;
         Utils.print(e.target.data + "关注倚天QQ空间");
         var result:int = int(e.target.data);
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("已经成功关注《倚天》QQ空间。");
            QplusShareCGMessage.CG_BLOG_STEP(3);
            if(GameScene.instance.hasFrameCallBack(this.runTime))
            {
               GameScene.instance.removeFrameCallBack(this.runTime);
            }
         }
         else if(!this.isFirstCare)
         {
            this.isFirstCare = true;
            url = "http://user.qzone.qq.com/2202410325";
            reNet = new URLRequest(url);
            navigateToURL(reNet);
         }
      }
      
      private function getHandle(evt:MouseEvent) : void
      {
         var grid:View_Grid = null;
         var p:Point = null;
         if(this.stateArr[2] == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("30114",3));
            return;
         }
         QplusShareCGMessage.CG_BLOG_GIFT();
         var i:int = 0;
         while(i < 3)
         {
            grid = this.rewardItemArr[i];
            p = new Point(grid.x,grid.y);
            p = localToGlobal(p);
            Tween.gridToBagBezierFuncDef(grid,-1,p.x,p.y);
            i++;
         }
      }
      
      public function closeZoneBtn() : void
      {
         this.zoneBtn.enabled = false;
         this.zoneBtn.mouseEnabled = false;
      }
      
      public function set state(arr:Array) : void
      {
         var i:int = 0;
         var btn:Button = null;
         var t:int = 0;
         this.stateArr = arr;
         i = 0;
         while(i < 4)
         {
            btn = this.btnArr[i] as Button;
            t = int(arr[i]);
            if(t == 0)
            {
               btn.enabled = true;
               btn.mouseEnabled = true;
            }
            else if(t == 1)
            {
               btn.enabled = false;
               btn.mouseEnabled = false;
            }
            i++;
         }
         if(arr[2] == 1 && arr[3] == 0)
         {
            this.getBtn.mouseEnabled = true;
            this.getBtn.enabled = true;
         }
         else
         {
            this.getBtn.mouseEnabled = false;
            this.getBtn.enabled = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            QplusShareCGMessage.CG_MICRO_BLOG();
         }
         else if(GameScene.instance.hasFrameCallBack(this.runTime))
         {
            GameScene.instance.removeFrameCallBack(this.runTime);
         }
      }
   }
}


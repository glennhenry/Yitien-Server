package com.yiTian.view.modules.actions.jiJin.chongzhi
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.actions.jiJin.FundMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class Child_chongItem extends Sprite
   {
      
      private var bmp:Bitmap;
      
      private var gridBmp:Bitmap;
      
      private var sendTf:MyTextField;
      
      private var cardBm:Bitmap;
      
      private var typeIn:int;
      
      public function Child_chongItem()
      {
         super();
         this.cardBm = ComponentUtil.getBitmap("Card_01",this,{
            "x":0,
            "y":0
         },Global.JiJin_Imgsdm);
         this.bmp = ComponentUtil.getBitmap("YuanBao10",this,{
            "x":12,
            "y":2
         },Global.JiJin_Imgsdm);
         this.sendTf = ComponentUtil.getTextField("赠送 00",this,{
            "x":10,
            "y":73,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.gridBmp = new Bitmap();
         addChild(this.gridBmp);
         ComponentUtil.setPropertie(this.gridBmp,{
            "x":56,
            "y":69
         });
         this.bmp.visible = false;
         this.sendTf.visible = false;
         this.gridBmp.visible = false;
         ComponentUtil.getButton("","Button_Recharge",this,{
            "x":16,
            "y":92 + 55,
            "textColor":16184781,
            "callBack":function(e:MouseEvent):void
            {
               buyHandle(e);
            }
         },Global.JiJin_Imgsdm);
      }
      
      public function update(_type:int) : void
      {
         var obj:Object = null;
         this.typeIn = _type;
         this.cardBm.bitmapData = ComponentUtil.getBitmapData("Card_0" + _type,Global.JiJin_Imgsdm);
         var ss:String = "YuanBao1" + FundMter.zeRoArr[_type - 1];
         this.bmp.bitmapData = ComponentUtil.getBitmapData(ss,Global.JiJin_Imgsdm);
         if(_type == 1)
         {
            this.sendTf.visible = false;
            this.gridBmp.visible = false;
         }
         else
         {
            this.sendTf.visible = false;
            this.gridBmp.visible = false;
            this.sendTf.text = "赠送  " + FundMter.sendArr[_type - 1];
            obj = FundMter.idArrData[_type - 1];
            Utils.getLoadBitmap("resource/image/chongzhi/" + obj.id + ".png",this.gridBmp);
         }
      }
      
      public function buyHandle(e:MouseEvent = null) : void
      {
         if(Boolean(FundMter.chongZhiId.length))
         {
            this.phpDataHd();
         }
         else
         {
            Model_chongzhi.initData(this.phpDataHd);
         }
      }
      
      private function phpDataHd() : void
      {
         var _itemId:int = int(FundMter.chongZhiId[this.typeIn - 1]);
         var loadurl:String = "http://token.app100621282.twsapp.com/buy_goods.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&goodsid=" + _itemId + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
         var loader:URLLoader = new URLLoader();
         var url:URLRequest = new URLRequest(loadurl);
         url.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.loaded);
         loader.load(url);
      }
      
      private function loaded(e:Event) : void
      {
         var arr:Array = null;
         var param:String = null;
         Utils.print(e.target.data);
         var tempItems:Array = (e.target.data as String).split("|");
         var len:int = int(tempItems.length);
         var i:int = 0;
         while(i < len)
         {
            arr = (tempItems[i] as String).match(/[\w]{1,15}=/i);
            trace(arr);
            if(Boolean(arr) && arr[0] == "url_params=")
            {
               param = (tempItems[i] as String).replace(arr[0],"");
               ExternalInterface.call("chongzhi",param);
               break;
            }
            i++;
         }
      }
   }
}


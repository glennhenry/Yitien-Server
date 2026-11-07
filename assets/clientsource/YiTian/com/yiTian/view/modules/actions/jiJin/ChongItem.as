package com.yiTian.view.modules.actions.jiJin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Utils;
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
   
   public class ChongItem extends Sprite
   {
      
      private var tfbm:Bitmap;
      
      private var sendTf:MyTextField;
      
      private var bm:Bitmap;
      
      private var typeIn:int;
      
      public function ChongItem()
      {
         super();
         this.tfbm = ComponentUtil.getBitmap("YuanBao10000",this,{
            "x":14,
            "y":0
         },Global.JiJin_Imgsdm);
         this.sendTf = ComponentUtil.getTextField("赠送00",this,{
            "x":8,
            "y":55,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.bm = new Bitmap();
         addChild(this.bm);
         ComponentUtil.setPropertie(this.bm,{
            "x":51,
            "y":54
         });
         ComponentUtil.getButton("购买","Button_store",this,{
            "x":0,
            "y":76,
            "textColor":16184781,
            "callBack":function():void
            {
            }
         },Global.Img_Cdm);
      }
      
      private function butHd(e:MouseEvent) : void
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
      
      public function update(_type:int) : void
      {
         var obj:Object = null;
         this.typeIn = _type;
         var ss:String = "YuanBao1" + FundMter.zeRoArr[_type - 1];
         this.tfbm.bitmapData = ComponentUtil.getBitmapData(ss,Global.JiJin_Imgsdm);
         if(_type == 1)
         {
            this.sendTf.visible = false;
            this.bm.visible = false;
         }
         else
         {
            this.sendTf.visible = true;
            this.bm.visible = true;
            this.sendTf.text = "赠送" + FundMter.sendArr[_type - 1];
            obj = FundMter.idArrData[_type - 1];
            Utils.getLoadBitmap("resource/image/chongzhi/" + obj.id + ".png",this.bm);
         }
      }
   }
}


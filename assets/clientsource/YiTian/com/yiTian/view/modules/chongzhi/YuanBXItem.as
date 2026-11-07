package com.yiTian.view.modules.chongzhi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
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
   
   public class YuanBXItem extends Sprite
   {
      
      private var IconName_text:MyTextField;
      
      private var Discript_text:MyTextField;
      
      private var Price_text:MyTextField;
      
      private var gridBm:Bitmap;
      
      private var sendDis:MyTextField;
      
      private var heroBm:Bitmap;
      
      private var buy_Button:Button;
      
      private var _itemId:int;
      
      public function YuanBXItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.gridBm = new Bitmap();
         addChild(this.gridBm);
         this.sendDis = ComponentUtil.getTextField(LangConfig.getWord("10604",1),this,{
            "color":16773818,
            "y":92,
            "size":14,
            "realWidth":55,
            "align":"right"
         });
         this.heroBm = new Bitmap();
         this.heroBm.x = 58;
         this.heroBm.y = 91;
         addChild(this.heroBm);
         this.buy_Button = ComponentUtil.getButton(LangConfig.getWord("10605",1) + "  ","Button_store",this,{
            "y":126,
            "textColor":16773818
         },Global.Img_Cdm);
         this.buy_Button.textColor = 16773818;
         this.buy_Button.textOverColor = 16383744;
         this.buy_Button.addEventListener(MouseEvent.CLICK,this.buyHandle);
      }
      
      public function update(item:Vo_item, sendData:Object) : void
      {
         this._itemId = item.id;
         Utils.getLoadBitmap("resource/image/icon60/" + item.str_icon + ".png",this.gridBm);
         if(int(sendData.id) == 0)
         {
            this.sendDis.visible = false;
            this.heroBm.visible = false;
         }
         else
         {
            this.sendDis.visible = true;
            this.heroBm.visible = true;
            this.sendDis.text = LangConfig.getWord("10604",1) + " " + sendData.count;
            Utils.getLoadBitmap("resource/image/chongzhi/" + sendData.id + ".png",this.heroBm);
         }
      }
      
      public function buyHandle(e:MouseEvent = null) : void
      {
         var loadurl:String = "http://token.app100621282.twsapp.com/buy_goods.php?openid=" + Global.account + "&openkey=" + Global.openkey + "&goodsid=" + this._itemId + "&fpkey=" + Global.fpkey + "&zoneid=" + Global.zoneid + "&pf=" + Global._pf + "&r=" + getTimer();
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

